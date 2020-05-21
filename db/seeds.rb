# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_bot_rails'

FactoryBot.create_list(:posts, 20)

Page.create(title: "speaking")
Page.create(title: "writing")
Page.create(title: "about")