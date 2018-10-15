FactoryBot.define do
  factory :payment_method do
    user_id { 1 }
    last4 { "1234" }
    expiration_month { 10 }
    expiration_year { 2023 }
    brand { "Visa" }
    stripe_id { "987654321" }
  end
end
