FactoryBot.define do
  factory :address do
    prefecture_id { 1 }
    postal_code { "123-4567" }
    city { "福岡市" }
    house_number { "1-1-1" }
    building_name { "アマミヤビル" }
  end
end