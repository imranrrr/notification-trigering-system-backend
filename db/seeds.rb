# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


pp Admin.create!(name: "Admin", email: "emranlateef786@gmail.com", password: "Admin@123", password_confirmation: "Admin@123" )
pp User.create!(first_name: "Dummy", last_name: "User", email: "emranlateef786@gmail.com", password: "User@123", password_confirmation: "User@123")

pp 5.times {|i| WebSignage.create(name: "web signage #{i}", scroller_speed: 5, landscape_title_width: "5px", landscape_title_height: "5px", landscape_title_top: "5px", landscape_title_left: "5px", landscape_description_width: "5px", landscape_description_height: "5px", landscape_description_top: "5px", landscape_description_left: "5px", potrait_title_width: "5px", potrait_title_height: "5px", potrait_title_top: "5px", potrait_title_left: "5px", potrait_description_width: "5px", potrait_description_height: "5px", potrait_description_top: "5px", potrait_description_left: "5px")}

pp Location.create!(name: "Test Location", web_signage_id: WebSignage.first.id)
pp Location.create!(name: "Test Location 2", web_signage_id: WebSignage.last.id)

pp EndpointGroup.create!(name: "Test End Point Group", description: "testing description", endpoint_type: 2)
pp EndpointGroup.create!(name: "Test End Point Group 2", description: "testing description 2", endpoint_type: 2)

pp Destination.create!(destination_type: 1, network_distribution_id: 111222333, resource_url: "http://www.example.com")
pp Destination.create!(destination_type: 0, network_distribution_id: 111222444, resource_url: "http://www.example2.com")

pp Endpoint.create!(name: "Test Endpoint", description: "test description for endpoint", location_id: Location.first.id, endpoint_group_id: EndpointGroup.first.id, destination_id: Destination.first.id)
pp Endpoint.create!(name: "Test Endpoint 2", description: "test description for endpoint 2", location_id: Location.second.id, endpoint_group_id: EndpointGroup.second.id, destination_id: Destination.second.id)


pp Template.create!(name: "test template", body: "test body", subject: "test subject", user_id: User.first.id, background_color: "#000000", font_color: "#fff")

pp Package.create!(name: "Silver", price: 20, duration: 0)
pp Package.create!(name: "Gold", price: 40, duration: 1)
pp Package.create!(name: "Premium", price: 60, duration: 2)