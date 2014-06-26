require 'faker'

FactoryGirl.define do
	factory :post do |f|
		f.title "Testing Post"
		f.text "This is a simple testing post. I hope it works."
	end

	factory :invalid_post, parent: :post do |f|
		f.title nil
	end
end