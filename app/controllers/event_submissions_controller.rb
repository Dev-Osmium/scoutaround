# this is the controller used when submitting at the Event level
# (where the requirement being fulfilled isn't yet known)

class EventSubmissionsController < AuthenticatedController
  before_action :find_submission, except: [:new, :create, :index]

  def index
    @submissions = @event.event_submissions

    # apply filtering
    event_registration_id = params[:registration]
    event_requirement_id  = params[:event_requirement_id]
    @submissions = @submissions.select { |sub| sub.event_registration_id == event_registration_id.to_i } if event_registration_id.present?
    @submissions = @submissions.select { |sub| sub.event_requirement_id  == event_requirement_id.to_i } if event_requirement_id.present?

    event_requirement = @event.event_requirements.find(event_requirement_id) if event_requirement_id.present?

    respond_to do |format|
      format.json { render json: @submissions || [] }
      format.pdf do
        pdf_combiner = CombinePDF.new
        @submissions.each do |submission|
          if submission.attachment.attached?
            pdf_combiner << CombinePDF.parse(submission.attachment.download)
          end
        end

        combined_filename = [
          UnitPresenter.unit_display_name(@unit),
          @unit.city,
          "#{event_requirement.description.pluralize}.pdf"
        ].join(' ')

        send_data pdf_combiner.to_pdf, filename: combined_filename, type: "application/pdf"
      end
    end
  end

  def show
    # TODO: pundit this
  end

  def new
    @submission = EventSubmission.new(event_registration_id: params[:registration])
    @submission.event_requirement = @event_requirement

    # iterate through all event registrations and determine whether current user is allowed to
    # submit on behalf of that user. Admins can submit on behalf of anyone. Users can always submit
    # on their own behalf. Guardian can submit on behalf of their guardees. All others are prohibited.
    # TODO: extract this
    @visible_event_registrations = []
    @event.event_registrations.each do |registration|
      if @current_user_is_admin
        @visible_event_registrations << registration
      elsif registration.user == @current_user
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

    # destroy any previous submissions for this requirement, for this registration
    EventSubmission.where(
      event_requirement_id:  @submission.event_requirement_id,
      event_registration_id: @submission.event_registration_id
    ).destroy_all

    # resolve the EventRequirement
    @event_requirement = EventRequirement.find(params[:event_requirement_id])

    case @event_requirement.type
    when 'FeeEventRequirement'

      # TODO: extract this into a standalone module

      total = 0
      @current_user.family.each do |user|
        if user.is_member_of?(unit: @unit)
          registration = @event.event_registrations.find_by(user: user)
          if registration.present?
            user_fee = user.type == 'Youth' ? @event_requirement.amount_youth : @event_requirement.amount_adult
            total += user_fee
          end
        end
      end

      processing_fee = total * 0.029 + 30
      total += processing_fee

      expiration        = params[:expiration]
      expiration_parts  = expiration.split('/')
      exp_month         = expiration_parts[0]
      exp_year          = expiration_parts[1]
      card_number       = params[:card_number]
      cvc               = params[:cvc]

      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      charge = Stripe::Charge.create(
        amount:   total.to_i,
        currency: 'usd',
        source: {
          exp_month: exp_month,
          exp_year:  exp_year,
          number:    card_number,
          cvc:       cvc,
          object:    'card',
        }
      )

      # TODO: handle failed charges

      @submission.stripe_charge_id = charge.id

      # TODO: save card source data if user wants us to keep it on file

      if @submission.save
        # because payment is for the entire family, let's create
        # payment submissions for them, too
        @current_user.guardees.each do |user|
          registration = @event.event_registrations.find_by(user: user)
          if registration.present?
            @event_requirement.event_submissions.where(event_registration: registration).first_or_create
          end
        end

        redirect_to event_submission_path(@submission)
      end
    when 'DocumentEventRequirement'
      if @submission.save
        EventSubmissionNotifier.send_document_receipt_notifications(@submission)
        flash[:notice] = I18n.t(
          'submissions.confirmation.document_received',
          person: @submission.event_registration.user.full_name,
          document_name: @submission.event_requirement.description
        )
        redirect_to event_event_registrations_path(@event)
      end
    end
  end

  private

  def find_submission
    @submission = EventSubmission.find(params[:id])
  end

  def submission_params
    params
      .require(:event_submission)
      .permit(:attachment, :audience, :waived)
      .merge({ submitter: @current_user })
  end
end
