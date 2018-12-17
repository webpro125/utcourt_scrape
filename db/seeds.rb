# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = Admin.find_or_initialize_by(email: 'sokomheng89@gmail.com')
admin.password = 'test1234'
admin.save!

admin = Admin.find_or_initialize_by(email: 'edward@stonelawfirm.net')
admin.password = 'Harlan1872'
admin.save!