FactoryBot.define do
  factory :requirement do
    type { 'AchievementRequirement' }
    association achievable, factory: rank
    program_code { 'bsa' }
    sequence(:description) { |n| "description #{n}" }
  end
end
