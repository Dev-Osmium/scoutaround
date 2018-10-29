class AddTypeToDocumentLibraryItems < ActiveRecord::Migration[5.2]
  def change
  	add_column :document_library_items, :type, :string
  	add_column :document_library_items, :parent_id, :integer

  	DocumentLibraryItem.update_all(type: 'DocumentLibraryFile')

    execute('ALTER SEQUENCE document_library_items_id_seq RESTART WITH 66287')
  end

end
