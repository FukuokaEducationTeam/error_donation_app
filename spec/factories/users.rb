FactoryBot.define do
  factory :user do
    gimei = Gimei.name
    name { gimei.kanji }
    name_reading { gimei.last.katakana }
    nickname { Faker::Name.name }
  end
end