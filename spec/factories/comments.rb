# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do |f|
  	f.commenter
  	f.body "This is a simple comment. Who knows what will happen?"
  end
end
