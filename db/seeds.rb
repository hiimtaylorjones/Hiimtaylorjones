# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Admin.create!({:email => "admin@hiimtaylorjones.com", :password => ENV["SECRET_TEST_PASSWORD"], :password_confirmation => ENV["SECRET_TEST_PASSWORD"] })

Post.create(title: "Sample Post", tagline: "Sample", body: "testing this thing out here.", published: true)
Page.create(title: "speaking")
Page.create(title: "writing")
Page.create(title: "about")