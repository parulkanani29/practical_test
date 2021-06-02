# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..5).each do |a| 
	User.create!(email: "doctor#{a}@yopmail.com", password: 'password', password_confirmation: 'password', role: "doctor", name: "doctor#{a}")
end

(1..5).each do |a| 
	User.create!(email: "patient#{a}@yopmail.com", password: 'password', password_confirmation: 'password', role: "patient", name: "patient#{a}")
end
