class User < ApplicationRecord
  include UserPreferences

  preference :unit_announcement_notifications, 'always'
  preference :event_announcement_notifications, 'always'
  preference :notification_method, 'email'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :rank, optional: true
  has_many :memberships
  has_many :units, through: :memberships
  has_many :event_registrations
  has_many :registered_events, through: :event_registrations, class_name: 'Event'
  has_many :events, through: :units
  has_many :achievements
  has_one  :payment_method
  has_many :attendances
  has_one_attached :avatar

  #
  # let's pause here for a second. This is complicated.
  # A Guardianship is a join model for a many-to-many relationship
  # between Users
  #
  has_many :guardianships, foreign_key: 'guardian_id'
  has_many :guardees, through: :guardianships
  has_many :guardeeships, class_name: 'Guardianship', foreign_key: 'guardee_id'
  has_many :guardians, through: :guardeeships

  validates_presence_of :first_name, :last_name, :type
  delegate :next_rank, to: :rank
  accepts_nested_attributes_for :guardeeships, reject_if: :all_blank, allow_destroy: true
  scope :adults, -> { where(type: 'Adult') }
  scope :youths, -> { where(type: 'Youth') }

  def full_name
    result = "#{first_name} #{last_name}"
    result += ", #{post_nominal}" if post_nominal.present?
    result
  end

  def short_name
    "#{ nickname.present? ? nickname : first_name } #{ last_name }"
  end

  def initials
    "#{first_name[0]}#{last_name[0]}"
  end

  def preferred_name
    nickname.present? ? nickname : first_name
  end

  def multiple_units?
    units.count > 1
  end

  def anonymous_email?
    email =~ /anonymous_.*@scoutaround.org/
  end

  def family
    [self].concat(self.guardees)
  end

  def member_of?(unit)
    return false unless unit.present?
    unit.memberships.exists?(user_id: self.id)
  end

  def preference_for(key: nil, default: nil)
    self.user_preferences.find_by(key: key)&.value || default
  end

  def save_preference_for(key: nil, value: nil)
    pref = self.user_preferences.find_or_initialize_by(key: key)
    pref.update_attributes(value: value)
  end

  def card_on_file?
    self.stripe_customer_id.present?
  end

  def short_display_name
    "#{ nickname.present? ? nickname : first_name } #{last_name[0]}."
  end
end
