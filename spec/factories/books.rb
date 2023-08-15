FactoryBot.define do
  factory :book do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
end