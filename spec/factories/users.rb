FactoryBot.define do
  factory :user do
    association :person, factory: :adult
    sequence(:email) { |n| "user_#{n}@scoutaround.org" }
    password 'goscoutaround'
  end
end