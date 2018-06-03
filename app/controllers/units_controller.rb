class UnitsController < UnitContextController
  def show
    @upcoming_events = @unit.events.upcoming
  end

  def edit
  end

  def update
    if @unit.update_attributes(unit_params)
      flash[:notice] = I18n.t('units.success_update')
      redirect_to unit_path(@unit)
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:city)
  end
end
