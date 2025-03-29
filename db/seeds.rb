puts "Creating default roles..."
Role.create!(id: 1, name: "Admin")
Role.create!(id: 2, name: "Instructor")
puts "Roles created!"