require 'spec_helper'

describe User do
	it "Has a valid Factory" do
		FactoryGirl.create(:user).should be_valid
	end
	it "Should have an email" do
		FactoryGirl.build(:user, email: nil).should_not be_valid
	end 
	it "Should have a password" do
		FactoryGirl.build(:user, password: nil).should_not be_valid
	end
end
