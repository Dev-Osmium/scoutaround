class HomeController < AuthenticatedController
  def index
    redirect_to unit_path(@current_user.units.first)
  end
end
