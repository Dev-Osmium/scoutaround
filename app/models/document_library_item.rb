class DocumentLibraryItem < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :parent, class_name: 'DocumentLibraryItem', optional: true
  has_one_attached :document
  validate :parent_cannot_be_self
  scope :folders, -> { where(type: 'DocumentLibraryFolder') }

  def parent_cannot_be_self
  	return if id.nil?
  	errors.add(:parent_id, "Can't be self") if parent_id == id
  end
end
