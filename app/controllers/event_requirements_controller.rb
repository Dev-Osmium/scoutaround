class EventRequirementsController < EventContextController
  before_action :find_event_requirement, except: [:index, :new, :create]
  before_action :find_event
  before_action :find_unit

  def index
    @event_requirements = @event.event_requirements
    @body_classes = [:admin]
  end

  def new
    @event_requirement = @event.event_requirements.new
    @event_requirement.due_at = @event.starts_at - 1.week
    @event_requirement.audience = 'everyone'
  end

  def create
    @event_requirement = @event.event_requirements.new(event_requirement_params)
    @event_requirement.amount_youth = (@event_requirement.amount_youth || 0) * 100.0
    @event_requirement.amount_adult = (@event_requirement.amount_adult || 0) * 100.0

    if @event_requirement.save
      redirect_to unit_event_event_registrations_path(@unit, @event)
      return
    end

    redirect_to new_event_event_requirement_path(@event)
  end

  def edit
  end

  def update
    @event_requirement.assign_attributes(event_requirement_params)
    @event_requirement.amount_youth = (@event_requirement.amount_youth || 0) * 100.0
    @event_requirement.amount_adult = (@event_requirement.amount_adult || 0) * 100.0

    if @event_requirement.save
      flash[:notice] = I18n.t('event_requirements.confirm_update')
      redirect_to unit_event_event_registrations_path(@unit, @event)
    else
      redirect_to unit_event_event_requirement_path(@unit, @event, @event_requirement)
    end
  end

  private

  def event_requirement_params
    params.require(:event_requirement).permit(:description, :due_at, :type, :document_library_item_id, :audience, :required, :amount_youth, :amount_adult, :waive_transaction_fees)
  end

  def find_event_requirement
    @event_requirement = EventRequirement.find(params[:id])
  end

  def find_event
    if params[:event_id].present?
      @event = Event.find(params[:event_id])
    elsif @event_requirement.present?
      @event = @event_requirement.event
    end
  end

  def find_unit
    @unit = @event.unit
    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
  end
end
