ruby '3.2.2'
source 'https://rubygems.org'

gem 'rails',  '7.0.4.2'

# Database and server
gem 'pg'
gem 'puma', "4.3.12"

# AWS Assets
gem "aws-sdk-s3", require: false

# Authentication and Roles
gem 'devise'

# UI Frameworks and Gems
gem 'will_paginate'
gem 'sassc-rails'
gem 'webpacker', '~> 4.2.2'
gem 'react-rails', '2.6.0'

# Rendering and Tagging
gem 'github-markup', '4.0.1'
gem 'commonmarker', '~> 0.23.9'
gem 'acts-as-taggable-on', '~> 9.0'
gem 'friendly_id'

# Javascript and Coffeescript
gem 'uglifier'
gem 'turbolinks'
gem 'yui-compressor'

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
