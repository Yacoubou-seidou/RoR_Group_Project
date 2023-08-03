FactoryBot.define do
  factory :food do
    name { 'Food Item' }
    measurement_unit { 'gram' }
    price { 10.0 }
    quantity { 1 }
    association :user
  end
end
