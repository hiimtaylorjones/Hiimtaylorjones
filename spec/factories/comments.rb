require 'faker'

FactoryGirl.define do
	factory :comment do |f|
		f.commenter { Faker::Name.first_name }
		f.body "I really thought this article sucked"
	end 
end