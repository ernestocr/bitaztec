# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Required Settings
Setting.destroy_all
Setting.create(key: 'price', value: 30000)
Setting.create(key: 'active', value: 1)
Setting.create(key: 'max', value: 30000)
Setting.create(key: 'min', value: 1000)
Setting.create(key: 'premium', value: 0.1)
Setting.create(key: 'auto', value: 0)
