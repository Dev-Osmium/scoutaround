class Events::MessagesController < MessagesController
  before_action :find_event
  before_action :find_unit

  def index
    @messages = @event.messages
  end

  def new
    @message = Message.new
  end

  def create
    @message = @event.messages.new(message_params) if @event.present?
    @message.author = @current_user
    if @message.save
      EventMessageNotifier.send_message_notifications(@message)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :pingees)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_unit
    @unit = @event.unit
  end
end
