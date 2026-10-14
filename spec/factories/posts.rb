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

		f.trait :unpublished do
			published { false }
		end

		# `posts.published` has no DB default, so legacy rows can be NULL.
		f.trait :never_published do
			published { nil }
		end

		f.trait :with_banner_image do
			after(:build) do |post|
				post.banner_image.attach(
					io: Rails.root.join('spec/fixtures/files/banner.png').open,
					filename: 'banner.png',
					content_type: 'image/png'
				)
			end
		end
	end
end
