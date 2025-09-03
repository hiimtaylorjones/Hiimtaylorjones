ruby '3.4.5'
source 'https://rubygems.org'

gem 'rails',  '8.0.2'

# Database and server
gem 'pg', "~> 1.5.9"
gem 'puma', "~> 6.6.0"

# AWS Assets
gem 'aws-sdk-s3', '~> 1.183'

# Authentication and Roles
gem 'devise', '~> 4.9', '>= 4.9.4'

# UI Frameworks and Gems
gem 'will_paginate', '~> 4.0', '>= 4.0.1'
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'
gem 'bulma-rails', '~> 1.0', '>= 1.0.3'
gem 'terser', '~> 1.2', '>= 1.2.5'

# Rendering and Tagging
gem "commonmarker", "~> 2.3.1"
gem 'acts-as-taggable-on', '~> 12.0'
gem 'friendly_id', '~> 5.5.1'

# Rails 8 Stuff
gem "propshaft"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Testing assets
group :development, :test do
	gem 'rspec-rails', '~> 6.0.2'
	gem 'rails-controller-testing'
  gem 'factory_bot_rails'
	gem 'faker'
	gem 'pry'
	gem 'dotenv-rails'
end

gem "letter_opener", :group => :development
