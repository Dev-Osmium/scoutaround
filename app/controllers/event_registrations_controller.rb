class EventRegistrationsController < AuthenticatedController
  include ApplicationHelper
  before_action :find_registration, except: [:index, :new, :create]
  before_action :find_event
  before_action :find_unit

  def index
    authorize EventRegistration.new(event: @event)
    @body_classes = ['admin']
  end

  def show
    # TODO: pundit this
  end

  def new
  end

  def create
    if params[:user].present?
      perform_single_registration
    elsif params[:user_id].present?
      perform_family_registration
    elsif params['event']['registrant_ids'].present?
      perform_bulk_registration
    end

    redirect_to unit_event_path(@unit, @event)
  end

  def update
  end

  def destroy
    user = @registration.user
    @registration.destroy
    flash[:notice] = "Unregistered #{ user.full_name }"
    redirect_to unit_event_path(@unit, @event)
  end

  private

  def perform_single_registration
    user = @unit.members.find(params[:user])
    @registration = @event.event_registrations.create(user: user)
    flash[:notice] = I18n.t('event_registrations.success.created.single', user_name: user.first_name, event_name: @event.name)
  end

  def perform_bulk_registration
    users = @unit.members.find(params['event']['registrant_ids'])
    users.each do |user|
      @event.event_registrations.create(user: user)
    end

    flash[:notice] = "Registered #{ user_synopsis(users) }"
  end

  def perform_family_registration
    users = @unit.members.find(params[:user_id])
    users.each do |user|
      @event.event_registrations.create(user: user)
    end
  end

  def find_registration
    @registration = EventRegistration.find(params[:id])
  end

  def find_event
    if params[:event_id].present?
      @event = Event.find(params[:event_id])
    else
      @event = @registration&.event
    end
  end

  def find_unit
    @unit = @event&.unit
    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
  end
end
