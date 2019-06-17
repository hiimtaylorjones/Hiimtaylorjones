require 'faker'

FactoryBot.define do
	factory :post do |f|
		f.title 		{ Faker::Lorem.sentence }
		f.tagline		{ Faker::Lorem.sentence }
		f.body { Faker::Lorem.paragraphs(10).join("  ") } 
		f.published	{ true }
	end
end
