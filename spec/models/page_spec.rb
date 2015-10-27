require 'rails_helper'

RSpec.describe Page, :type => :model do
  it "should have a valid factory" do
    @page = FactoryGirl.create(:page)
    expect(@page).to be_valid
  end
end
