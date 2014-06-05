require 'spec_helper'

describe "basic_page/index.html.erb" do
  it "should have the content 'Everything Is Collateral'" do
  	visit root_path
  	expect(page).to have_content('Everything Is Collateral')
  end
end
