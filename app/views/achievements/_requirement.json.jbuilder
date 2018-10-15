achievement = (@achievements.select { |achievement| achievement.achievable_id == requirement.id })&.first

json.id           requirement.id
json.name         requirement.name
json.status       achievement.present? ? (achievement.earned_at.present? ? 'completed' : 'submitted') : 'not_started'
json.requirements requirement.requirements, partial: 'achievements/requirement', as: :requirement if requirement.requirements.present?
