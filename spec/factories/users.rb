FactoryBot.define do
  factory :user do
    first_name { 'first' }
    last_name { 'last' }
    type { 'Youth' }
    sequence(:email) { |n| "user_#{n}@scoutaround.org" }
    password { 'goscoutaround' }
  end

  factory :user_with_post_nominal, parent: :user do
    post_nominal { 'III' }
  end

  factory :youth, class: Youth, parent: :user do
    first_name { 'Youth' }
    last_name { 'Jones' }
  end

  factory :adult, class: Adult, parent: :user do
    first_name { 'Parent' }
    last_name { 'Jones' }
  end
end
