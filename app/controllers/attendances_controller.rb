class AttendancesController < UnitContextController
  before_action :find_event

  def index
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
