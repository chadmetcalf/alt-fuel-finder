# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(name: "Alisher", username: "alisher", email: "al@al.com", password: "password", password_confirmation: "password")
# itinerary = Itinerary.create!(user_id: user.id)
Place.create!(address: "Denver, CO", description: "great city", title: "Mile High", user_id: user.id)
Place.create!(address: "Albuqurque, NM", description: "nice city", title: "springs", user_id: user.id)
# Destination.create!(address: "Kansas City, MO", description: "northern city", title: "FortC")
