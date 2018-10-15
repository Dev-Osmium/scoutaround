FactoryBot.define do
  factory :magic_link do
    magic_linkable factory: :event_requirement
    sequence(:recipient) { |n| "recipient_#{n}@somewhere.org" }
    expires_at { 96.hours.from_now }
    unit   factory: :unit
    sender factory: :user
  end
end
