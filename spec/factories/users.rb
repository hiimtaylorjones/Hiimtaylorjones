# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    avatar                {}
  	email					        {"user@example.com"}
  	username				      {"exampleuser"}
  	password 				      {"Password69"}
  	password_confirmation	{"Password69"}
  	role					        {"admin"}
  	# Poor man's way: Comment out the line below and comment the line above
  	# to test what its like to deal with default users.
  	# role					{"default"}
  end
end
