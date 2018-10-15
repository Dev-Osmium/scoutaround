class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :event_submissions
  validates_presence_of :user, :event # don't allow empties
  validates_uniqueness_of :user, scope: :event # prevent duplicate registrations
  delegate :full_name, to: :user
  delegate :unit, to: :event
  scope :future, -> { joins(:event).where('events.ends_at < current_date') }

  def complete?
    completions = event.event_requirements.map { |requirement| requirement.completed_by?(user: self.user) }
    !completions.include? false
  end

  def incomplete?
    !self.complete?
  end

  # return the set of complete EventRegistrations
  def self.complete
    result = self.all.select { |registration| registration.complete? }
  end
end
