class DocumentLibraryFolder < DocumentLibraryItem
  has_many :children, class_name: 'DocumentLibraryItem', foreign_key: :parent_id
end
