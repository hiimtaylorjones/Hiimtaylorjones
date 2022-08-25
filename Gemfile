ruby '2.6.5'
source 'https://rubygems.org'

gem 'rails', '~> 6.1', '>= 6.1.6.1'

# Database and server
gem 'pg', '~> 1.4', '>= 1.4.3'
gem 'puma', '~> 5.6', '>= 5.6.5'

# AWS Assets
gem "aws-sdk-s3", require: false

# Authentication and Roles
gem 'devise'

# UI Frameworks and Gems
gem 'will_paginate'
gem 'therubyracer'
gem 'sassc-rails'
gem 'webpacker', '~> 4.2.2'
gem 'react-rails', '2.6.0'

# Rendering and Tagging
gem 'github-markup', '3.0.4'
gem 'commonmarker', '0.19.0'
gem 'acts-as-taggable-on', '~> 9.0', '>= 9.0.1'
gem 'friendly_id', '~> 5.4', '>= 5.4.2'

# Javascript and Coffeescript
gem 'uglifier'
gem 'turbolinks'
gem 'yui-compressor'

# Testing assets

group :development, :test do
	gem 'rspec-rails', '~> 5.1.2'
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
