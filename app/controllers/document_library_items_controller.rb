class DocumentLibraryItemsController < UnitContextController
  before_action :find_document_library_item, except: [:index, :new, :create]
  layout :get_layout

  def index
    @document_library_item = @unit.root_document_library_folder
    @document_library_items = @unit.root_document_library_folder.children
  end

  def show
  end

  def new
    @new_file = DocumentLibraryFile.new(parent_id: params[:parent_id])
  end

  def create
    @document_library_item = DocumentLibraryItem.new(document_params)
    @document_library_item.author = @current_user
    if @document_library_item.save!
      flash[:notice] = t('documents.confirm')
      redirect_to unit_document_library_items_path(@unit)
    else
      redirect_to new_unit_document_library_item_path(@unit)
    end
  end

  def destroy
    parent = @document_library_item.parent
    @document_library_item.destroy
    flash[:notice] = "Removed #{ @document_library_item.name }"
    redirect_to parent.present? ? unit_document_library_item_path(@unit, parent) : unit_document_library_items_path(@unit)
  end

  def update
    ap @document_library_item
    @document_library_item.update_attributes(document_params)
    ap @document_library_item
    redirect_to unit_document_library_item_path(@unit, @document_library_item)
  end

  private

  def find_document_library_item
    @document_library_item = DocumentLibraryItem.find(params[:id])
  end

  def document_params
    params.require(:document_library_item).permit(:name, :document, :parent_id, :type)
  end

  def get_layout
    (params[:view] || 'none') == 'embed' ? false : 'application'
  end
end
