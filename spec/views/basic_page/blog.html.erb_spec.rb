require 'spec_helper'

describe "basic_page/blog.html.erb" do
  it "should have the content 'Blog'" do
  	visit '/blog'
  	expect(page).to have_content('Blog')
  end
end
