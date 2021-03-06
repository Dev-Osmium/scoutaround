class EventRequirements::MagicLinksController < AuthenticatedController
  before_action :find_event_requirement
  before_action :find_event
  before_action :find_unit

  def new
  end

  def create
    @magic_link = @event_requirement.becomes(EventRequirement).magic_links.new(magic_link_params)
    @magic_link.sender = @current_user
    @magic_link.unit   = @unit

    if @magic_link.save
      flash[:notice] = t('magic_links.confirmation',
                          time_to_live: Settings.magic_links.default_time_to_live,
                          description: @event_requirement.description,
                          email: @magic_link.recipient)
      MagicLinkMailer.recipient_notification_email(@magic_link, @unit).deliver_later
      redirect_to edit_event_requirement_path(@event_requirement)
    else
      flash[:error] = "You've already shared #{ @event_requirement.description } with #{ @magic_link.recipient }"
      redirect_to new_event_requirement_magic_link_path(@event_requirement)
    end
  end

  private

  def find_event_requirement
    @event_requirement = EventRequirement.includes(:event).find(params[:event_requirement_id])
  end

  def find_event
    @event = @event_requirement.event
  end

  def find_unit
    @unit = @event.unit
  end

  def magic_link_params
    params.require(:magic_link).permit(:recipient)
  end
end
