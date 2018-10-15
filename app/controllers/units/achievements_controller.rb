# achievements controller for the unit

class Units::AchievementsController < UnitContextController
  def index
    @view = params[:view] || 'roster'
    @body_classes = [@view]
  end

  def update
    achievement_ids = params[:achievement][:id]
    achievements = Achievement.find(achievement_ids)
    achievements.each do |achievement|
      achievement.update_attributes(awarded_at: params[:awarded_at])
    end

    flash[:notice] = I18n.t('achievements.success.bulk_update', count: achievement_ids.count)
    redirect_to unit_achievements_path(@unit, view: :pending)
  end
end
