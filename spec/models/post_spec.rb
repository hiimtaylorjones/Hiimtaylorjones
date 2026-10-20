require 'rails_helper'

describe Post do
  it "should have a valid Factory" do
  	expect(FactoryBot.create(:post)).to be_valid
  end
  it "should have a title" do
  	expect(FactoryBot.build(:post, title: nil)).not_to be_valid
  end
  it "should have content" do
  	expect(FactoryBot.build(:post, body: nil)).not_to be_valid
  end

  describe "collection membership" do
    # Guards the `optional: true` on belongs_to — without it every existing
    # collection-less post fails validation.
    it "is valid without a collection" do
      expect(FactoryBot.build(:post, collection: nil)).to be_valid
    end

    it "reports the collection it belongs to" do
      collection = FactoryBot.create(:collection)
      post = FactoryBot.create(:post, collection: collection)
      expect(post.collection).to eq(collection)
      expect(collection.posts).to include(post)
    end
  end

  describe ".published" do
    it "excludes unpublished and never-published posts" do
      live = FactoryBot.create(:post)
      draft = FactoryBot.create(:post, :unpublished)
      legacy = FactoryBot.create(:post, :never_published)

      expect(Post.published).to include(live)
      expect(Post.published).not_to include(draft)
      expect(Post.published).not_to include(legacy)
    end
  end
end
