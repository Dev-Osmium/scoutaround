FactoryBot.define do
  factory :payment do
    external_id { "MyString" }
    submission_id { 1 }
    amount { 1 }
  end
end
