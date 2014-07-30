require 'spec_helper'

describe "basic_page/about.html.erb" do
  it "Should exist and have the correct header" do
  	visit '/about'
  	expect(page).to have_content("What's This All About?")
  end
end
