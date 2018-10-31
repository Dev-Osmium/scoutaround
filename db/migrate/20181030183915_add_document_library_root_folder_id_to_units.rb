class AddDocumentLibraryRootFolderIdToUnits < ActiveRecord::Migration[5.2]
  def change
  	add_column :units, :root_document_library_folder_id, :integer

    # create a new root folder for each unit
  	Unit.all.each do |unit|
  	  folder = DocumentLibraryFolder.create
  	  unit.root_document_library_folder_id = folder.id
  	  unit.save!

  	  # move the unit's stuff into the new root folder
  	  DocumentLibraryItem.where(parent_id: nil, unit_id: unit.id).update_all(parent_id: folder.id)
  	end

    # since library items no longer belong directly to units, drop the attribute
  	remove_column :document_library_items, :unit_id
  end
end
