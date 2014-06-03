require 'spec_helper'

describe "basic_page/about.html.erb" do
  it "Should have the content 'About Taylor Jones'" do
  	visit '/about'
  	expect(page).to have_content('About Taylor Jones')
  end
end
