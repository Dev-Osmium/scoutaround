FactoryBot.define do
  factory :unit do
    sequence(:number) { |n| "#{n}" }
    sequence(:city)   { |n| "city_#{n}"}
    sequence(:state)  { |n| "state_#{n}"}
    association :subscription_plan
    subscription_expires_at { 1.year.from_now }
  end

  factory :troop, parent: :unit do
    type { 'Troop' }
    program_code { 'bsa' }
  end
end
