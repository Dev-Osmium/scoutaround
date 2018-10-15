class Achievement < ApplicationRecord
  belongs_to :user # see note below
  belongs_to :achievable
  validates_uniqueness_of :user, scope: :achievable
  validate :achievable_is_concrete
  delegate :type,         to: :achievable
  delegate :name,         to: :achievable
  delegate :ordinal,      to: :achievable
  delegate :program_code, to: :achievable
  scope :merit_badges,           -> { joins(:achievable).where('achievables.type = ?',  'MeritBadge') }
  scope :ranks,                  -> { joins(:achievable).where('achievables.type = ?',  'Rank') }
  scope :non_advancement_awards, -> { joins(:achievable).where('achievables.type = ?',  'NonAdvancementAward') }
  scope :awardable,              -> { joins(:achievable).where('achievables.type != ?', 'Requirement') }
  scope :earned,                 -> { where('earned_at IS NOT NULL') }
  scope :unapproved,             -> { where('earned_at IS NULL') }
  scope :unawarded,              -> { where('awarded_at IS NULL') }
  has_many_attached :attachments

  #
  # don't allow achievements for "virtual" requirements
  # whose completeness is computed, not directly earned
  #
  def achievable_is_concrete
    errors.add(:achievable, 'Must be concrete') unless self.achievable.concrete?
  end

  def awarded?
    awarded_at.present?
  end
end

# At one point it seemed to make sense to have achievements associate
# with memberships. But, in fact, Achievements belong to User so
# that they're portable across units.
