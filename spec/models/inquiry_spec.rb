require 'rails_helper'

RSpec.describe Inquiry, :type => :model do
  it "should have a valid factory" do
    @inquiry = FactoryGirl.create(:inquiry)
    expect(@inquiry).to be_valid
  end
end
