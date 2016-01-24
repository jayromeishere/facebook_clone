# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


30.times {
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password"
  )
}

users = User.all

users.each do |user|
  10.times { user.posts.create(
    text: Faker::Lorem.paragraph
  ) }
end

senders = users[1..10]
receivers = users[20..30]

senders.each do |sender|
  receivers.each do |receiver|
    sender.active_friend_requests.create(
      requested_id: receiver.id,
      accepted: true
    )
  end
end
