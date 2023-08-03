FactoryBot.define do
  factory :recipe do
    name { 'Test Recipe' }
    preparation_time { 60 }
    cooking_time { 30 }
    description { 'A test recipe' }
    association :user, factory: :user
  end
end
