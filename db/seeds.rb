# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


5.times {|i| WebSignage.create(name: "web signage #{i}")}

Package.create!(name: "Silver", price: 20, duration: 0)
Package.create!(name: "Gold", price: 40, duration: 1)
Package.create!(name: "Premium", price: 60, duration: 2)