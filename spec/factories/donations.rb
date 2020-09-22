FactoryBot.define do
  factory :donation do
    price { "10000" }
    association :user
    association :address
  end
end