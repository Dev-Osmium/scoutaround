class AddTypeToDocumentLibraryItems < ActiveRecord::Migration[5.2]
  def change
  	add_column :document_library_items, :type, :string
  	add_column :document_library_items, :parent_id, :integer

  	DocumentLibraryItem.update_all(type: 'LibraryFile')
  end
end
