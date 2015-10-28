# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do |f|
    f.title 		{ Faker::Lorem.sentence }
    f.content   { Faker::Lorem.paragraph }
  end
end
