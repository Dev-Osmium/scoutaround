class UnitSettingsController < UnitContextController
  include UnitContext

  before_action :set_session_unit_id

  def index
  end

  def show
  end

  def edit
    authorize @unit.becomes(Unit)
    @body_classes = [:admin, params[:id]]
  end

  def update
    authorize @unit.becomes(Unit)

    if @unit.update_attributes(unit_params)
      flash[:notice] = I18n.t('units.success_update')
      redirect_to unit_unit_settings_path(@unit)
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:city, :state, :council, :district, :chartering_organization_name, :time_zone)
  end

  # this is necessary for Stripe setup. The return route from Stripe can't be dynamic, so
  # we need to cache the id of the unit we're setting up
  def set_session_unit_id
    session[:unit_id] = @unit.id
  end
end
