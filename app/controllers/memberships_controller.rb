class MembershipsController < UnitContextController
  before_action :find_member, except: [:index, :new, :create]
  before_action :find_unit

  def index
    @body_classes = ['hide-none']

    term = params[:term]
    if term.present?
      terms = term.downcase.split(' ')
      where_clauses = []
      terms.each do |name|
        where_clauses << "LOWER(users.first_name) LIKE '%#{ name }%'"
        where_clauses << "LOWER(users.last_name) LIKE '%#{ name }%'"
      end

      where_clause = where_clauses.join(' OR ')
      puts where_clause

      @memberships = @unit.memberships.includes(:user).where(where_clause).order('users.first_name')
    else
      @memberships = @unit.memberships.includes(:user).order('users.first_name')
    end

    @members = @memberships.map { |m| m.user }

    respond_to do |format|
      format.html
      format.csv  { send_data @memberships.to_csv, filename: "#{@unit.type}-#{@unit.number}-#{Date.today}.csv" }
      format.json { render json: @members }
    end
  end

  def show
    @view = params[:view] || 'future'
    if @view == 'future'
      @registrations = @unit.event_registrations.future.where(user_id: @membership.user_id)
    elsif @view == 'all_registrations'
      @registrations = @unit.event_registrations.where(user_id: @membership.user_id)
    end
  end

  def edit
    @eligible_positions = @unit.unit_positions.where(audience: @membership.user.type.downcase).select { |p| !p.exclusive || (p.exclusive && p.memberships.none?) }
  end

  def new
    @membership = @unit.memberships.build
    @user = @membership.build_user
    @user.type = (params[:type] || 'youth').titleize
    @eligible_positions = @unit.unit_positions.where(audience: @user.type.downcase)
  end

  def create
    @membership = @unit.memberships.new(membership_params)
    @membership.user.email = "anonymous_#{ SecureRandom.hex(12) }@scoutaround.org" if @membership.user.email.empty?
    @membership.user.password = SecureRandom.hex(12)
    if @membership.save
      flash[:notice] = t('memberships.new.confirm', full_name: @membership.user.full_name)
      redirect_to unit_memberships_path(@unit)
      return
    end

    redirect_to new_unit_membership_path(@unit)
  end

  def update
    @membership.assign_attributes(membership_params)
    @membership.user.email = @user.email if @user.anonymous_email? && @membership.user.email.empty?
    @membership.user.email = "anonymous_#{ SecureRandom.hex(12) }@scoutaround.org" if @membership.user.email.empty?

    if @membership.save
      process_guardianships


      flash[:notice] = t('memberships.updated', full_name: @membership.user.full_name)
      redirect_to unit_membership_path(@unit, @membership)
    else
      redirect_to edit_unit_membership_path(@unit, @membership)
    end
  end

  def new
    @membership = @unit.memberships.build
    @user = @membership.build_user
    @user.type = (params[:type] || 'youth').titleize
    @eligible_positions = @unit.unit_positions.where(audience: @user.type.downcase)
  end

  def create
    @membership = @unit.memberships.new(membership_params)
    @membership.user.email = "anonymous_#{ SecureRandom.hex(12) }@scoutaround.org" if @membership.user.email.empty?
    @membership.user.password = SecureRandom.hex(12)
    if @membership.save!
      process_guardianships

      respond_to do |format|
        format.html do
          flash[:notice] = t('memberships.new.confirm', full_name: @membership.user.full_name)
          redirect_to unit_memberships_path(@unit)
          return
        end

        format.js
      end
    else
      redirect_to new_unit_membership_path(@unit)
    end
  end

  private

  def process_guardianships
    if params[:guardians].present?
      guardian_ids = params[:guardians].split(',')

      # remove unused guardianships
      @membership.user.guardeeships.each do |guardeeship|
        guardeeship.destroy unless guardian_ids.include? guardeeship.guardian_id
      end

      # create new guardianships as needed
      guardian_ids.each do |id|
        puts "Guardian user id #{id}"
        @membership.user.guardeeships.where(guardian_id: id).first_or_create
      end
    end # if params

    if params[:guardees].present?
      guardee_ids = params[:guardees].split(',')

      # remove unused guardianships
      @membership.user.guardianships.each do |guardianship|
        guardianship.destroy unless guardee_ids.include? guardianship.guardee_id
      end

      # create new guardianships as needed
      guardee_ids.each do |id|
        puts "Guardee user id #{id}"
        @membership.user.guardianships.where(guardee_id: id).first_or_create
      end
    end # if params
  end

  def find_member
    @membership = Membership.includes(:user).find(params[:id])
    # @membership = @unit.memberships.includes(:user).find(params[:id])
    @user = @membership.user
  end

  def find_unit
    @unit = Unit.find(params[:unit_id]) if params[:unit_id].present?
    @unit = @membership.unit if @membership.present?
    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
  end

  def membership_params
    params.require(:membership).permit(
      :unit_position_id,
      user_attributes: [:id, :rank_id, :first_name, :last_name,
        :nickname, :post_nominal, :type, :email, :phone, :avatar,
        :date_of_birth, guardeeships_attributes: [:id, :guardian_id, :_destroy]
      ]
    )
  end
end
