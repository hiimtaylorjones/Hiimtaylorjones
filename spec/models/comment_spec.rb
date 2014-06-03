require 'spec_helper'

describe Comment do
  it "should have a valid Factory" do
  	FactoryGirl.create(:comment).should be_valid
  end
  it "should have a commenter" do
  	FactoryGirl.build(:comment, commenter: nil).should_not be_valid
  end
  it "should have a body" do
  	FactoryGirl.build(:comment, body: nil).should_not be_valid
  end
end
