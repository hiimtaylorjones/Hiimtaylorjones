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
end
