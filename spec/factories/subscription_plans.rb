FactoryBot.define do
  factory :subscription_plan do
    sequence(:sku)            { |n| "sku_#{n}" }
    sequence(:display_name)   { |n| "display_name_#{n}" }
    sequence(:internal_name)  { |n| "internal_name_#{n}" }
    frequency                 { 'monthly' }
    price                     { 900 }
  end
end
