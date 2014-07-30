require 'spec_helper'

describe Post do
  it "should have a valid Factory" do
  	expect(FactoryGirl.create(:post)).to be_valid
  end
  it "should have a title" do
  	expect(FactoryGirl.build(:post, title: nil)).not_to be_valid
  end
  it "should have content" do
  	expect(FactoryGirl.build(:post, text: nil)).not_to be_valid
  end
end
