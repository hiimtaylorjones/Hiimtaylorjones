require 'rails_helper'

describe Collection do
	it "should have a valid Factory" do
		expect(FactoryBot.create(:collection)).to be_valid
	end

	it "should have a title" do
		expect(FactoryBot.build(:collection, title: nil)).not_to be_valid
	end

	it "generates a friendly slug from the title" do
		collection = FactoryBot.create(:collection, title: "Learning Rust")
		expect(collection.slug).to eq("learning-rust")
		expect(Collection.friendly.find("learning-rust")).to eq(collection)
	end

	it "defaults to unpublished" do
		expect(Collection.new.published).to eq(false)
	end

	describe "destroying a collection" do
		# The whole point of dependent: :nullify — deleting a grouping must not
		# delete the writing inside it.
		it "keeps its posts and leaves them standalone" do
			collection = FactoryBot.create(:collection, :with_posts, post_count: 2)
			post_ids = collection.posts.map(&:id)

			expect { collection.destroy }.not_to change { Post.count }

			post_ids.each do |id|
				expect(Post.find(id).collection).to be_nil
			end
		end
	end

	describe ".with_published_posts" do
		it "excludes a published collection with no published posts" do
			empty = FactoryBot.create(:collection)
			FactoryBot.create(:post, :unpublished, collection: empty)

			expect(Collection.with_published_posts).not_to include(empty)
		end

		it "excludes an unpublished collection even when its posts are live" do
			draft = FactoryBot.create(:collection, :unpublished)
			FactoryBot.create(:post, collection: draft)

			expect(Collection.with_published_posts).not_to include(draft)
		end

		it "includes a published collection with at least one published post" do
			live = FactoryBot.create(:collection, :with_posts, post_count: 2)

			expect(Collection.with_published_posts).to include(live)
		end

		it "lists a collection once, not once per post" do
			live = FactoryBot.create(:collection, :with_posts, post_count: 3)

			expect(Collection.with_published_posts.to_a.count(live)).to eq(1)
		end
	end
end
