# a handful of controllers rely on @event being set. This base controller
# takes care of that (and, by virtue of inheriting from UnitContextController,
# also sets @unit)

class EventsController < UnitContextController
  before_action :find_event, except: [:index, :new, :create]
  before_action :fetch_view_preference, only: [:index]
  after_action  :store_view_preference, only: [:index]

  def index
    session[:calendar_list_start_date] ||= Date.today.to_s
    session[:calendar_list_end_date]   ||= 6.months.from_now.to_s
    session[:calendar_include_unpublished] ||= 'no'

    if params[:change].present? && params[:to].present?
      session[params[:change]] = params[:to]
    end

    @start_date = Date.parse(session[:calendar_list_start_date])
    @end_date   = Date.parse(session[:calendar_list_end_date])
    @earlier_start_date  = (@start_date - 1.day).beginning_of_year
    @later_end_date      = @end_date + 6.months
    @include_unpublished = session[:calendar_include_unpublished] == 'yes'

    if @view == 'list'
      @events = @unit.events.where('starts_at >= ? AND starts_at <= ?', @start_date, @end_date)
    else
      @events = @unit.events
    end

    @events = @events.published unless @include_unpublished

    # for modal
    @event = Event.new
    @event.starts_at = 6.weeks.from_now
    @event.ends_at   = 6.weeks.from_now
    @event.registration_closes_at = 5.weeks.from_now

    @tracking_properties = { view: @view }

    # this is bound to be inefficient, but let's get it working first
    if params[:filter] == 'registered'
      @events = @events.reject do |event|
        family_registrants = []

        @current_user.family.each do |user|
          family_registrants << user if event.registered_for?(user: user)
        end

        family_registrants.count.zero?
      end
    end

    respond_to do |format|
      format.html
      format.ics { render layout: false }
    end
  end

  def show
    @registrations = @event.event_registrations.includes(:user).order('users.first_name', 'users.last_name')
  end

  def edit
    # TODO: pundit this
    @body_classes = [:admin]
    @needs_admin_coaching = @current_user.preference_for(key: :needs_admin_coaching, default: 'true') == 'true'
    @current_user.save_preference_for(key: :needs_admin_coaching, value: 'false')
  end

  def new
    @event = Event.new
    @event.starts_at = 6.weeks.from_now
    @event.ends_at   = 6.weeks.from_now
    @event.registration_closes_at = 5.weeks.from_now
  end

  def publish
    path = unit_event_path(@unit, @event)
    @event.update_attributes(published: true)
    @unit.messages.create(
      author: @current_user,
      body: "#{ @event.name} has been published to the #{ @unit.type } calendar. View details <a href='/units/#{ @unit.id }/events/#{ @event.id }'>here</a>."
    )
    flash[:notice] = "#{ @event.name} has been published to the calendar."
    redirect_to path
  end

  def create
    @event = @unit.events.new(event_params)

    if params[:starts_at_time] != '0'
      starts_at = Time.parse(params[:starts_at_time])
      ends_at = Time.parse(params[:ends_at_time])
      @event.starts_at = @event.starts_at.change({ hour: starts_at.hour, min: starts_at.min })
      @event.ends_at = @event.ends_at.change({ hour: ends_at.hour, min: ends_at.min })
    end

    if @event.save
      repeat_until = Date.parse(params[:repeat_until])

      if params[:repeat] != 'never'
        current_start_date = @event.starts_at
        current_end_date = @event.ends_at

        until current_start_date > repeat_until do
          # weekly is the only repeat option, so just add a week
          current_start_date += 1.week
          current_end_date += 1.week

          # instantiate a new event
          event = @unit.events.new(event_params)
          event.starts_at = current_start_date
          event.ends_at = current_end_date

          # save it
          event.save
        end
      end

      flash[:notice] = t('events.confirm')
      @body_classes = nil
      redirect_to unit_events_path(@unit)
    end
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to unit_event_path(@unit, @event)
    else
      redirect_to edit_unit_event_path(@unit, @event)
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = t('events.confirmations.cancel')
    redirect_to unit_events_path(@unit)
  end

  private

  def find_event
    @event = @current_user.events.find(params[:id] || params[:event_id])
    @body_classes = @event.published ? ['published'] : ['unpublished']
    flash[:alert] = 'This event is unpublished.' unless @event.published
    @unit = @event.unit
    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
    @membership = Membership.where(user: @current_user, unit: @event.unit).first
  end

  def event_params
    params.require(:event).permit(:name, :location, :starts_at, :ends_at, :require_registration,
      :registration_closes_at, :address, :city, :state, :postal_code, :banner_image_url,
      :published, :event_type, :description, :minimum_age, attachments: [])
  end

  def fetch_view_preference
    @view  = params[:view]  || @current_user.preference_for(key: :unit_events_view,  default: :list)
    @month = params[:month] || @current_user.preference_for(key: :unit_events_month, default: Date.today.month)
    @year  = params[:year]  || @current_user.preference_for(key: :unit_events_year,  default: Date.today.year + 1)
  end

  def store_view_preference
    @current_user.save_preference_for(key: :unit_events_view,  value: @view)
    @current_user.save_preference_for(key: :unit_events_month, value: @month)
    @current_user.save_preference_for(key: :unit_events_year,  value: @year)
  end
end
