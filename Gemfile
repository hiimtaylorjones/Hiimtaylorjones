ruby file: ".ruby-version"
source 'https://rubygems.org'

gem 'rails', '~> 8.0', '>= 8.0.4.1'

# Database and server
gem 'pg', "~> 1.5.9"
gem 'puma', "~> 8.0", ">= 8.0.2"

# AWS Assets
gem 'aws-sdk-s3', '~> 1', '>= 1.208.0'

# Admin passwords (has_secure_password)
gem "bcrypt", "~> 3.1"

# UI Frameworks and Gems
gem 'will_paginate', '~> 4.0', '>= 4.0.1'

# Rendering
gem "commonmarker", "~> 2.10.1"
gem 'friendly_id', '~> 5.5.1'

# Rails 8 Stuff
gem "propshaft"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Testing assets
group :development, :test do
	gem 'rspec-rails', '~> 8.0'
	gem 'rails-controller-testing'
  gem 'factory_bot_rails'
	gem 'faker'
end

gem "letter_opener", :group => :development
