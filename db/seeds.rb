# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username:  "ExampleUser",
             email: "example@rails.org",
             password:              "foobarfoo",
             password_confirmation: "foobarfoo",
             created_at: 1.minutes.ago,
             confirmed_at: Time.zone.now)

99.times do |n|
  username  = "example-#{n+1}"
  email = "example-#{n+1}@rails.org"
  password = "password"
  User.create!(username:  			 	username,
               email: 					email,
               password:              	password,
               password_confirmation: 	password,
               created_at: 				1.minutes.ago,
               confirmed_at: 			Time.zone.now)
end

# Scores
user = User.first
40.times do
  time = rand(20000)+5000
  course = rand(3) + 1
  pointer_var = rand(6)
  pointer =  if pointer_var < 3 
            "touchpad"
          elsif pointer_var > 3
            "mouse"
          else
            "trackball"
          end
  hand =  if time > 18000
            "left"
          else
            "right"
          end
  user.scores.create!(time: time, course: course, 
                      pointer: pointer, hand: hand) 
end
