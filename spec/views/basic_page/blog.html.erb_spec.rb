require 'spec_helper'

describe "basic_page/blog.html.erb" do
  it "should have the content 'Blog'" do
  	visit '/blog'
  end
end
