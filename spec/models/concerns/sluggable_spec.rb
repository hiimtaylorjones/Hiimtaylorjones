require 'rails_helper'

# Behaviour carried over from friendly_id; Collection stands in for both models.
RSpec.describe Sluggable do
	it "builds the slug from the title" do
		expect(FactoryBot.create(:collection, title: "Learning Rust").slug).to eq("learning-rust")
	end

	it "keeps the slug when the title changes, so links survive a rename" do
		collection = FactoryBot.create(:collection, title: "Learning Rust")
		collection.update!(title: "Learning Rust, Again")
		expect(collection.reload.slug).to eq("learning-rust")
	end

	it "suffixes a duplicate title instead of colliding" do
		FactoryBot.create(:collection, title: "Same Title")
		second = FactoryBot.create(:collection, title: "Same Title")
		expect(second.slug).to match(/\Asame-title-\h{8}-\h{4}-\h{4}-\h{4}-\h{12}\z/)
	end

	it "rejects a slug that would clash with a route" do
		collection = FactoryBot.build(:collection, title: "New")
		expect(collection).not_to be_valid
		expect(collection.errors[:slug]).to include("is reserved")
	end

	it "uses the slug in URLs" do
		post = FactoryBot.create(:post, title: "Hello World")
		expect(Rails.application.routes.url_helpers.post_path(post)).to eq("/posts/hello-world")
	end

	it "keeps the saved slug in URLs while an edit is invalid" do
		post = FactoryBot.create(:post, title: "Hello World")
		post.slug = ""
		expect(post.to_param).to eq("hello-world")
	end

	describe ".find_by_slug_or_id!" do
		let!(:post) { FactoryBot.create(:post, title: "Hello World") }

		it "finds by slug" do
			expect(Post.find_by_slug_or_id!("hello-world")).to eq(post)
		end

		it "falls back to the numeric id for old links" do
			expect(Post.find_by_slug_or_id!(post.id.to_s)).to eq(post)
		end

		it "raises RecordNotFound for an unknown slug" do
			expect { Post.find_by_slug_or_id!("nope") }.to raise_error(ActiveRecord::RecordNotFound)
		end
	end
end
