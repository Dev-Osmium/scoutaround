FactoryBot.define do
  factory :user_preference do
    association :user
    key { "MyString" }
    value { "MyString" }
  end
end
