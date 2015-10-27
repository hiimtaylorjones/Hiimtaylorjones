# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inquiry do |f|
    f.name              { Faker::Name.name }
    f.company           { Faker::Company.name }
    f.email             { Faker::Internet.email }
    f.phone             { Faker::PhoneNumber.cell_phone }
  end
end
