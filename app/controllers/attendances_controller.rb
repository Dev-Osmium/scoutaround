class AttendancesController < EventContextController
  before_action :find_event_members, only: [:index, :edit]

  def index
  	redirect_to unit_event_edit_attendance_path(@unit, @event) if @event.attendances.count.zero?
  end

  def edit
  end

  def create
  	params[:user_ids].each do |user_id|
  	  @event.attendances.create(user_id: user_id)
  	end
  	flash[:notice] = "Recorded #{ params[:user_ids].count } attendees"
  	redirect_to unit_event_path(@unit, @event)
  end

  private

  def find_event_members
    @members = @event.require_registration ? @event.event_registrations.map { |r| r.user } : @unit.memberships.map { |m| m.user }
  end
end
