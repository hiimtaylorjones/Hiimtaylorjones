# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :comment do |f|
    f.association :post
  	f.email { Faker::Internet.email }
    f.message  { Faker::Lorem.paragraph }
    f.approved { true }
    f.rating { rand(5) + 1 }
  end
end
