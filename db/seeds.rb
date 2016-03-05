# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin = User.create({
    username: "admin",
    password: "password",
    password_confirmation: "password",
    about: "About the Admin",
    admin: true
  })

user = User.create({
    username: "user",
    password: "password",
    password_confirmation: "password",
    about: "About the Basic user",
  })



[
  {content: "I have never been to Cuba and would like to visit, would I like it?", title: "How is Cuba?"},
  {content: "What kind of cars do everyday Cubans Drive?", title: "What cars do you drive?"},
  {content: "I play basketball", title: "What do you do for fun?"},
  {title: "I just ran out of titles", content: "Imagine a great title and text here."},
].each do |item|
  admin.items.create(item).save
  user.items.create(item).save
end

[admin, user].each do |u|
  puts "created user: #{u.attributes.inspect}"
end

