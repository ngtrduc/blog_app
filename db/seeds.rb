# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
50.times do |n|
name = Faker::Name.name
email = "ducnt-#{n+1}@gmail.com"
user_name ="ngtrduc#{n+1}"
password = "123456"
User.create!(name: name,
email: email,
password:
password,
password_confirmation: password)
end
users = User.order(:created_at).take(6)
10.times do |n|
title = "Test #{n+1}"
content = Faker::Lorem.sentence(5)
users.each { |user| user.posts.create!(title: title, content: content) }
end

users = User.all
user = users.first
following = users[2..10]
followers = users[3..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }