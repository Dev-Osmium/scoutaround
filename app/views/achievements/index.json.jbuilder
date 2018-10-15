json.next_rank do
  json.name @next_rank.name
  json.requirements @next_rank.requirements.order(:ordinal), partial: 'achievements/requirement', as: :requirement
end

json.merit_badges do
  @user.achievements.merit_badges.each do |merit_badge|
    json.name        merit_badge.name
    json.earned_at   merit_badge.earned_at
    json.awarded_at  merit_badge.awarded_at
    json.approved_by merit_badge.approved_by
  end
end

json.achievements do
  json.array! @user.achievements.awardable.order(:earned_at).each do |achievement|
    json.id         achievement.id
    json.name       achievement.name
    json.type       achievement.type
    json.earned_at  achievement.earned_at
    json.awarded_at achievement.awarded_at
  end
end

