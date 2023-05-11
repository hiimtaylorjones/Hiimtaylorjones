ruby '3.2.2'
source 'https://rubygems.org'

gem 'rails',  '7.0.4.2'

# Database and server
gem 'pg'
gem 'puma', "6.2.2"

# AWS Assets
gem "aws-sdk-s3", require: false

# Authentication and Roles
gem 'devise'

# UI Frameworks and Gems
gem 'will_paginate'
gem 'sassc-rails'
gem "bulma-rails", "~> 0.9.4"

# Rendering and Tagging
gem 'github-markup', '4.0.1'
gem 'commonmarker', '~> 0.23.9'
gem 'acts-as-taggable-on', '~> 9.0'
gem 'friendly_id'

# Testing assets
group :development, :test do
	gem 'rspec-rails', '6.0.2'
	gem 'rails-controller-testing'
  gem 'factory_bot_rails'
	gem 'faker'
	gem 'pry'
	gem 'dotenv-rails', groups: [:development, :test]
end

gem "letter_opener", :group => :development

group :production do
	gem 'rails_12factor'
end