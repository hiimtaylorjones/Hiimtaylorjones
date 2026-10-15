require 'faker'

FactoryBot.define do
	factory :collection do |f|
		f.title				{ Faker::Lorem.sentence }
		f.description	{ Faker::Lorem.paragraph }
		f.active			{ true }

		f.trait :inactive do
			active { false }
		end

		f.trait :with_posts do
			transient do
				post_count { 3 }
			end

			after(:create) do |collection, evaluator|
				FactoryBot.create_list(:post, evaluator.post_count, collection: collection)
			end
		end
	end
end
