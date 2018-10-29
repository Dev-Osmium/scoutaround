class AddAuthorIdToDocumentLibraryItems < ActiveRecord::Migration[5.2]
  def change
    add_column :document_library_items, :author_id, :integer
  end
end
