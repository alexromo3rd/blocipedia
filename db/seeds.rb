require 'faker'

# Create Users
25.times do
  user = User.new(
    email:    Faker::Internet.email,
    password: "password",
    password_confirmation: "password"
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

15.times do
  Wiki.create!(
    user:  users.sample,
    title: Faker::Lorem.word,
    body:  Faker::ChuckNorris.fact
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"