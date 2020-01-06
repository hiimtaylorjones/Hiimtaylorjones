require 'faker'

def generate_post_body
	paragraphs = []
	15.times do
		paragraphs << Faker::Lorem.paragraph(sentence_count: 5)
	end
	return paragraphs.join(" ")
end

FactoryBot.define do
	factory :post do |f|
		f.title 		{ Faker::Lorem.sentence }
		f.tagline		{ Faker::Lorem.sentence }
		f.body { generate_post_body } 
		f.published	{ true }
	end
end
