class Unit < ApplicationRecord
  has_many :events
  has_many :event_registrations, through: :events
  has_many :memberships
  has_many :members, -> { where('memberships.active = true') }, through: :memberships, source: 'user'
  has_many :document_library_items
  has_many :messages, as: :messagable

  # when fetching achievements for a unit, we only want those achievements belonging to
  # the same program. For instance, we don't want to show Cub Scout achievements in a
  # Boy Scout troop.
  has_many :achievements, -> (object) { joins(:achievable).where('achievables.program_code = ?', object.program_code) }, through: :members
  # has_many :achievements, through: :members
  has_many :magic_links
  has_many :unit_positions
  belongs_to :primary_wiki_article, class_name: 'WikiArticle', optional: true
  belongs_to :subscription_plan
  validates_presence_of :number, :city, :state, :subscription_expires_at
  validates_uniqueness_of :number, scope: [:city, :state]
  before_create :set_trial_expiration
  after_create :create_unit_positions

  def membership_for(user: nil)
    self.memberships.find_by(user: user)
  end

  def role_for(user: nil)
    # memberships.where(user: user)&.first&.role
    membership_for(user: user)&.role
  end

  def ranks
    Rank.where(program_code: self.program_code).order(:ordinal)
  end

  def self.types
    [
      { id: 'Troop', name: 'Scout Troop',    program_code: 'bsa' },
      { id: 'Pack',  name: 'Cub Pack',       program_code: 'cubs' },
      { id: 'Crew',  name: 'Venturing Crew', program_code: 'venturing' },
      { id: 'Post',  name: 'Explorer Post',  program_code: 'exploring' }
    ]
  end

  def accepts_payments?
    self.stripe_user_id.present?
  end

  # Based on the unit's program (BSA, cubs, etc), set up basic positions.
  # These are potentially customizable
  def create_unit_positions
    prototype_positions = PrototypePosition.where(program_code: self.program_code)
    prototype_positions.each do |position|
      self.unit_positions.create(name: position.name, audience: position.audience)
    end
  end

  def set_trial_expiration
    self.subscription_plan = SubscriptionPlan.first
    self.subscription_expires_at = 30.days.from_now
  end

  def subscription_expired?
    self.subscription_expires_at < Date.today
  end
end
