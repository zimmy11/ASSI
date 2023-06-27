# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create([{user_id: "Marco", email: "zimmy@gmail.com",role: "organizer",password: "alfa"},{user_id: "Alfonso", email: "alfo@gmail.com",role: "user",password: "alll"},{user_id: "Giorgio", email: "gio@gmail.com",role: "user",password: "12345"}])


Presale.create(user_id: 1, event_id: 1)
Presale.create(user_id: 2, event_id: 1)
Presale.create(user_id: 3, event_id: 2)
Presale.create(user_id: 4, event_id: 2)
Presale.create(user_id: 5, event_id: 3)
