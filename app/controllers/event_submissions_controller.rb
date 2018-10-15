# this is the controller used when submitting at the Event level
# (where the requirement being fulfilled isn't yet known)

class EventSubmissionsController < UnitContextController
  before_action :find_event_requirement
  before_action :find_event_registration
  before_action :find_event
  before_action :find_submission, except: [:new, :create, :index]

  def index
    @submissions = @event.event_submissions

    # apply filtering
    event_registration_id = params[:registration]
    event_requirement_id  = params[:event_requirement_id]
    @submissions = @submissions.select { |sub| sub.event_registration_id == event_registration_id.to_i } if event_registration_id.present?
    @submissions = @submissions.select { |sub| sub.event_requirement_id  == event_requirement_id.to_i } if event_requirement_id.present?
    @event_requirement = @event.event_requirements.find(event_requirement_id) if event_requirement_id.present?

    respond_to do |format|
      format.json { render json: @submissions || [] }
      format.pdf do
        exporter = EventRequirementExporter.new(@event_requirement)
        exporter.export_pdf do |data, filename, mime_type|
          send_data data, filename: filename, type: mime_type, disposition: 'attachment'
        end
      end
      format.zip do
        exporter = EventRequirementExporter.new(@event_requirement)
        exporter.export_zip do |data, filename, mime_type|
          send_file data, filename: filename, type: mime_type, disposition: 'attachment'
        end
      end
    end # respond_to
  end # index

  def show
    # TODO: pundit this
  end

  def new
    @submission = EventSubmission.new(
      event_requirement:  @event_requirement,
      event_registration: @event_registration
    )

    @visible_event_registrations = []
    @event.event_registrations.each do |registration|
      if @current_user_is_admin
        @visible_event_registrations << registration
      elsif registration.user_id == @current_user.id
        @visible_event_registrations << registration
      elsif @current_user.guardees.include? registration.user
        @visible_event_registrations << registration
      else
        # nope
      end
    end
  end

  def create
    @submission = EventSubmission.new(submission_params)

    # resolve the EventRequirement
    @event_requirement = EventRequirement.find(params[:event_requirement_id]) if params[:event_requirement_id].present?
    @event_requirement ||= EventRequirement.find(@submission.event_requirement_id)
    @event = @event_requirement.event
    @submission.event_requirement = @event_requirement

    # destroy any previous submissions for this requirement, for this registration
    EventSubmission.where(
      event_requirement_id:  @event_requirement.id,
      event_registration_id: @submission.event_registration.id
    ).destroy_all

    case @event_requirement.type
    when 'FeeEventRequirement'
      process_credit_card

      if @submission.save!
        # because payment is for the entire family, let's create
        # payment submissions for them, too
        @current_user.guardees.each do |user|
          registration = @event.event_registrations.find_by(user: user)
          if registration.present?
            submission = @event_requirement.event_submissions.new(
              event_registration:  registration,
              submitter:           @current_user,
              stripe_charge_id:    @charge.id,
              cc_last_4:           @charge.source.last4,
              cc_expiration_month: @charge.source.exp_month,
              cc_expiration_year:  @charge.source.exp_year,
              payment:             @submission.payment
            )
            submission.save!
          end
        end

        # send email, set flash, redirect
        flash[:notice] = 'You\'ve paid!'
        EventSubmissionNotifier.send_payment_receipt_notification(@submission)
        redirect_to unit_event_path(@unit, @event)
      end # if submission save
    when 'DocumentEventRequirement'
      if @submission.save
        EventSubmissionNotifier.send_document_receipt_notifications(@submission)
        flash[:notice] = I18n.t(
          'submissions.confirmation.document_received',
          person: @submission.event_registration.user.full_name,
          document_name: @submission.event_requirement.description
        )
        redirect_to unit_event_path(@unit, @event)
      end
    end
  end

  private

  def process_credit_card
    total = 0
    @current_user.family.each do |user|
      if user.member_of?(@unit)
        registration = @event.event_registrations.find_by(user: user)
        if registration.present?
          user_fee = user.type == 'Youth' ? @event_requirement.amount_youth : @event_requirement.amount_adult
          total += user_fee
        end
      end
    end

    processing_fee = total * 0.029 + 30
    total += processing_fee
    description = "#{ UnitPresenter.unit_display_name(@event.unit )} #{ @event.name } #{ @submission.event_registration.user.full_name }"

    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    stripe_token = params[:stripe_token]

    # There are three possible charge scenarios:
    #
    # 1. user has a card on file and wants to use it
    # 2. user has a card on file and wants to replace it
    # 3. user doesn't have a card on file and wants to have a card on file
    # 4. user has a card on file but wants to use something else and not remember it
    # 5. user doesn't have a card on file and doesn't want to have a card on file
    #
    # 4 and 5 are functionally equivalent: they're one-off charges
    #
    # The card_on_file param will only be present if a card had previously been on file
    # (the form renderer takes care of that), so we'll use that to trigger
    # scenarios 1 and 2

    if params[:card_on_file] == 'use' && @current_user.card_on_file?
      # scenario 1
      customer = Stripe::Customer.retrieve(@current_user.stripe_customer_id)
    elsif params[:card_on_file] == 'replace' && params[:remember] == '1' && @current_user.card_on_file?
      # scenario 2
      customer = Stripe::Customer.retrieve(@current_user.stripe_customer_id)
      customer.source = stripe_token
      customer.save
    elsif params[:remember] == '1'
      # scenario 3
      customer = Stripe::Customer.create(
        email: @current_user.email,
        source: stripe_token
      )
    end

    # Now let's run the charge.
    # Once we've reached this point, if a customer is populated then we can
    # safely assume a card is on file. Otherwise we'll perform a one-off charge.

    if customer.present?
      @charge = Stripe::Charge.create(
        amount:      total.to_i,
        currency:    'usd',
        description: description,
        customer:    @current_user.stripe_customer_id,
        destination: {
          account: @event.unit.stripe_user_id
        }
      )
    else # one-off charge
      @charge = Stripe::Charge.create(
        amount:      total.to_i,
        currency:    'usd',
        description: description,
        source:      stripe_token,
        destination: {
          account: @event.unit.stripe_user_id
        }
      )
    end

    ap @charge
    # TODO: handle failed charges

    @submission.payment = Payment.create(
      external_id:      @charge.id,
      brand:            @charge.source.brand,
      expiration_month: @charge.source.exp_month,
      expiration_year:  @charge.source.exp_year,
      last4:            @charge.source.last4
    )

    if params[:remember] || '0' == '1'
      @current_user.update_attributes(stripe_customer_id: customer[:id])
      PaymentMethod.create(user: @current_user) unless @current_user.payment_method.present?
      @current_user.reload
      @current_user.payment_method.update_attributes(
        brand:            @charge.source.brand,
        expiration_month: @charge.source.exp_month,
        expiration_year:  @charge.source.exp_year,
        last4:            @charge.source.last4
      )
    end
  end

  def find_unit
    @unit = Unit.find(params[:unit_id])
  end

  def find_event
    return unless params[:event_id].present?
    @event = Event.find(params[:event_id])
  end

  def find_event_requirement
    return unless params[:event_requirement_id].present?
    @event_requirement = EventRequirement.find(params[:event_requirement_id])
    @event = @event_requirement.event
  end

  def find_submission
    @submission = EventSubmission.find(params[:id])
  end

  def find_event_registration
    return unless params[:registration].present?
    @event_registration = EventRegistration.find(params[:registration])
    @event = @event_registration.event
  end

  def submission_params
    return unless params[:event_submission].present?

    params
      .require(:event_submission)
      .permit(:event_registration_id, :event_requirement_id, :attachment, :remember)
      .merge({ submitter: @current_user })
  end
end
