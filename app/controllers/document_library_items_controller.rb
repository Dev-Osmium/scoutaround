class DocumentLibraryItemsController < UnitContextController
  before_action :find_document_library_item, except: [:index, :new, :create]

  def index
    @document_library_items = @unit.document_library_items.where(parent_id: nil)
  end

  def show
  end

  def new
    @document_library_item = DocumentLibraryItem.new(unit: @unit)
  end

  def create
    @document_library_item = @unit.document_library_items.new(document_params)
    if @document_library_item.save
      flash[:notice] = t('documents.confirm')
      redirect_to unit_document_library_items_path(@unit)
    else
      redirect_to new_unit_document_library_item_path(@unit)
    end
  end

  private

  def find_document_library_item
    @document_library_item = @unit.document_library_items.find(params[:id])
  end

  def document_params
    params.require(:document_library_item).permit(:name, :document)
  end
end
