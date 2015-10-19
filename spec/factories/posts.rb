require 'faker'

FactoryGirl.define do
	factory :post do |f|

		f.title 		{ Faker::Lorem.sentence }
		f.tagline		{ Faker::Lorem.sentence }
		f.body			{
									Faker::Lorem.paragraph +
									"\n\n" + Faker::Lorem.paragraph(10) +
									"\n\n" + Faker::Lorem.paragraph(10) +
									"\n\n" + Faker::Lorem.paragraph(10) +
									"\n\n" + Faker::Lorem.paragraph(10) +
									"\n\n" + Faker::Lorem.paragraph(10) +
									"\n\n" + Faker::Lorem.paragraph(10) +
									"\n\n" + Faker::Lorem.paragraph(10) 
								}
		f.published	{ true }
	end
end
