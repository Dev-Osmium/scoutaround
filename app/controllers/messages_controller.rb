class MessagesController < UnitContextController
  def create
    @message = @unit.messages.new(message_params)
    @message.author = @current_user
    if @message.save!
      redirect_to unit_path(@unit)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
