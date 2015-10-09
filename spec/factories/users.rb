# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do

    p = Faker::Internet.password

  	email					        { Faker::Internet.email }
  	username				      { Faker::Internet.user_name }
  	password 				      { p }
  	password_confirmation	{ p }
  end
end
