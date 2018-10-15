FactoryBot.define do
  factory :event_requirement do
    association :event
    required { true }
    sequence(:description) { |n| "Event requirement #{n}" }
  end

  factory :document_event_requirement, class: DocumentEventRequirement, parent: :event_requirement do
  end

  factory :payment_event_requirement, class: FeeEventRequirement, parent: :event_requirement do
    amount_adult { 1 }
    amount_youth { 1 }
  end
end
