class UnitPosition < ApplicationRecord
  belongs_to :unit
  has_many :memberships
  validates_presence_of :name, :audience
  before_destroy :prevent_orphans

  def prevent_orphans
    return unless membership.any?
    errors.add(:base, "This position is currently held and therefore can't be deleted.")
    throw(:abort)
  end
end
