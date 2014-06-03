require 'spec_helper'

describe "basic_page/resume.html.erb" do
  it "should have the content 'Resume'" do
  	visit '/blog'
  	expect(page).to have_content('Resume')
  end
end
