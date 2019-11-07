require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "should have a valid factory" do
    @admin = FactoryBot.create(:admin)
    expect(@admin).to be_valid
  end
end
