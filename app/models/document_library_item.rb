class DocumentLibraryItem < ApplicationRecord
  belongs_to :unit
  belongs_to :author, class_name: 'User'
  has_one_attached :document
end
