class AnnouncementsController < UnitContextController
  def index
    @messages = @unit.messages.includes(:author)
  end
end
