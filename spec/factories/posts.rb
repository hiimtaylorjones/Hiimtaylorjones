require 'faker'

FactoryBot.define do
	factory :post do |f|
		f.title 		{ Faker::Lorem.sentence }
		f.tagline		{ Faker::Lorem.sentence }
		f.published	{ true }

		after(:create) do |post|
			dir = Rails.root.join("db", "posts")
			FileUtils.mkdir_p(dir)
			paragraphs = Array.new(5) { Faker::Lorem.paragraph(sentence_count: 5) }
			content = paragraphs.join("\n\n")
			File.write(dir.join("#{post.slug}.md"), content)
		end
	end
end
