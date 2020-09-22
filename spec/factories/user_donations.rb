FactoryBot.define do
  factory :user_donation do
    gimei = Gimei.name
    name { gimei.kanji }
    name_reading { gimei.last.katakana }
    nickname { Faker::Name.name }
    prefecture_id { 1 }
    postal_code { "123-4567" }
    city { "福岡市" }
    house_number { "1-1-1" }
    building_name { "アマミヤビル" }
    price { "10000" }
    token { "tok_0a0a0a0a0a0a0a0a0a0a0a0a" }
    association :user
    association :address
    association :donation
  end
end