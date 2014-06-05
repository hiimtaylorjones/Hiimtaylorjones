require 'spec_helper'

describe Post do
  it "should have a valid Factory" do
  	FactoryGirl.create(:post).should be_valid
  end
  it "should have a title" do
  	FactoryGirl.build(:post, title: nil).should_not be_valid
  end
  it "should have content" do
  	FactoryGirl.build(:post, text: nil).should_not be_valid
  end
end
