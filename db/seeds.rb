# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.new
user.email = 'admin@techhoppers.com'
user.password = 'password'
user.password_confirmation = 'password'
user.user_type = "ADMIN"
user.user_sub_type = "ADMIN"
user.travels_name = "Techhoppers Running Status"
user.authentication_code = "T2E3C4H5"
user.save!