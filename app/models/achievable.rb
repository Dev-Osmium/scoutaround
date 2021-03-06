class Achievable < ApplicationRecord
  has_many :requirements, class_name: 'Achievable', foreign_key: 'parent_achievable_id', dependent: :destroy

  #
  # recursively returns all sub-requirements that, in turn,
  # don't have sub-requirements ("leaf nodes" on the tree).
  # A leaf node will have zero requirements. This is liable
  # to be an expensive database operation, so best to find
  # some way of caching it
  #
  def leaves
    result = []

    # iterate over each sub-requirement
    self.requirements.each do |requirement|
      if requirement.leaf?
        result << requirement # add to result if it's a leaf...
      else
        result.concat requirement.leaves # ...otherwise, go down a level
      end
    end

    result
  end

  #
  # is this requirement a leaf (has no further sub-requirements)?
  #
  def leaf?
    requirements.count.zero?
  end

  #
  # has a given user achieved this Achievable?
  #
  def achieved_by?(user: nil)
    return false unless user.present?
    user.achievements.exists?(achievable: self)
  end

  #
  # given a user, return a completion quotient, which is the
  # number of completed leaf requirements divided by the total number
  # of leaf requirements
  #
  def progress_for(user: nil)
    return 0 unless user.present?

    leaves = self.leaves
    achievable_ids = leaves.map { |r| r.id } # collect all the leave achievable id's
    achievements = user.achievements.where('achievable_id in (?)', achievable_ids)
    achievement_count = achievements.count

    # MultipleChoiceRequirements are considered leaves, but will never have associated achievements
    # because they're computed "on the fly," so we need to compute them, too
    leaves.select { |r| r.is_a?(MultipleChoiceRequirement) }.each do |requirement|
      achievement_count += 1 if requirement.completed_by?(user: user)
    end

    (achievements.count.to_f / leaves.count.to_f) * 100
  end

  # Some Requirements are "virtual" as opposed to concrete.
  # Virtual requirements are ones that have sub-requirements.
  # The completeness of a virtual is computed, whereas a completed
  # concrete requirement will have a corresponding achievement
  #
  def concrete?
    true
  end
end
