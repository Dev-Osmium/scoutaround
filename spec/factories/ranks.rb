FactoryBot.define do
  factory :rank do
    sequence(:name) { |n| "rank #{n}"}
    program_code { 'bsa' }
  end

  trait :scout do
    name { 'Scout' }
  end

  trait :tenderfoot do
    name { 'Tenderfoot' }
  end
end
