# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
location = InventoryLocation.create
container_a = location.containers.create
container_b = location.containers.create
location.root_container = container_a
location.save
container_a.child_containers << container_b
