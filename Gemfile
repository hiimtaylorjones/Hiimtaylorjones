source 'https://rubygems.org'
ruby '2.1.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
gem 'sprockets', '~> 2.9'
gem 'bcrypt'

# Database and server
gem 'pg'
gem 'unicorn'

# Authentication and Roles
gem 'cancancan'
gem 'devise'

# UI Frameworks and Gems
gem 'will_paginate', '~> 3.0'
gem 'will_paginate-bootstrap'
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

# Backend uploading gems
gem 'aws-sdk'
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'redcarpet', github: 'vmg/redcarpet'
gem 'acts-as-taggable-on'

# Javascript and Coffeescript
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'yui-compressor'
gem 'compass-rails'

# Testing assets

group :development, :test do 
	gem 'spring-commands-rspec'
	gem 'rspec-rails', '~> 3.0.0'
  	gem 'factory_girl_rails', '4.4.0'
  	gem "fakefs", :require => "fakefs/safe"
end

# Testing Assets

group :test do
	gem 'selenium-webdriver'
	gem 'capybara'
	gem 'guard-rspec'
	gem 'launchy'
	gem 'faker'
end


# Heroku Assets
gem 'spring',        group: :development
gem 'rails_serve_static_assets', group: :production
gem 'rails_12factor', group: :production