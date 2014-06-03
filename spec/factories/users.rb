# spec/factories/contacts.rb 
require 'faker'

FactoryGirl.define do
	factory :user do |f|
		f.email "helloworld@helloworld.com"
		f.password "helloworld"
		f.password_salt { BCrypt::Engine.generate_salt }
		f.password_hash { password_hash = BCrypt::Engine.hash_secret("helloworld", password_salt) }
	end
end