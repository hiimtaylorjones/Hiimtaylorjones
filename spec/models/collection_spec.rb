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

	it "defaults to inactive" do
		expect(Collection.new.active).to eq(false)
	end

	describe "deactivating a collection" do
		# The reversible counterpart to destroy: membership survives, so the
		# series reassembles when it is switched back on.
		it "keeps its posts as members so the grouping can be restored" do
			collection = FactoryBot.create(:collection, :with_posts, post_count: 2)

			collection.update!(active: false)

			expect(collection.reload.posts.count).to eq(2)
			expect(collection.posts.first.collection).to eq(collection)
		end
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

	describe ".listable" do
		it "excludes an active collection with no published posts" do
			empty = FactoryBot.create(:collection)
			FactoryBot.create(:post, :unpublished, collection: empty)

			expect(Collection.listable).not_to include(empty)
		end

		it "excludes an inactive collection even when its posts are live" do
			inactive = FactoryBot.create(:collection, :inactive)
			FactoryBot.create(:post, collection: inactive)

			expect(Collection.listable).not_to include(inactive)
		end

		it "includes an active collection with at least one published post" do
			live = FactoryBot.create(:collection, :with_posts, post_count: 2)

			expect(Collection.listable).to include(live)
		end

		it "lists a collection once, not once per post" do
			live = FactoryBot.create(:collection, :with_posts, post_count: 3)

			expect(Collection.listable.to_a.count(live)).to eq(1)
		end
	end
end
