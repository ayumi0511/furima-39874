FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    concept { Faker::Name.name }
    price { 300 }
    category_id          { 2 }
    situation_id         { 2 }
    shipping_charge_id { 2 }
    shipping_area_id          { 2 }
    shipping_date_id          { 2 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
