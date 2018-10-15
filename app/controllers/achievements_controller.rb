# this controller is invoked when viewing achievements for a
# single user. Not to be confused with Units::AchievementsController,
# which is invoked when viewing achievements for a unit


class AchievementsController < UnitContextController
  before_action :find_achievement, except: [:index, :new, :create]
  before_action :find_membership

  def index
    @next_rank = @user&.rank&.next_rank || @unit.ranks.first
    @achievements = @user.achievements.order(:earned_at)
    @view = params[:view] || 'rank_progress'
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @achievement = Achievement.new(earned_at: Date.today)
  end

  def create
    @achievement = @user.achievements.new(achievement_params)
    if @achievement.save
      respond_to do |format|
        format.html do
          flash[:notice] = I18n.t('advancement.success.merit_badge', name: @user.first_name, badge: @achievement.achievable.name)
          redirect_to unit_membership_achievements_path(@unit, @membership) unless request.xhr?
        end
        format.json
      end
    else
    end
  end

  def edit
  end

  def destroy
    @achievement.destroy
    respond_to do |format|
      format.json { render json: {}, status: :deleted }
    end
  end

  def show
  end

  # this one gets called through an unnested route
  def update
    if @achievement.update_attributes(achievement_params)
      flash[:notice] = 'Update successful'
      redirect_to unit_membership_achievement_path(@unit, @membership, @achievement)
    end
  end

  private

  def achievement_params
    params.require(:achievement).permit(:achievable_id, :earned_at, :approved_by, attachments: [])
  end

  def find_achievement
    @achievement = Achievement.find(params[:id])
  end

  def find_membership
    if params[:membership_id].present?
      @membership = Membership.find(params[:membership_id])
      @user = @membership.user
    end
  end

  # def find_unit
  #   if params[:unit_id].present?
  #     @unit = @current_user.users.find(params[:unit_id])
  #   elsif @membership.present?
  #     @unit = @membership.unit
  #   end

  #   @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
  # end
end
