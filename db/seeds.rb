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
Setting.create(key: 'price_range_1', value: '0-500')
Setting.create(key: 'price_range_2', value: '501-1000')
Setting.create(key: 'price_range_3', value: '1001-5000')
Setting.create(key: 'price_range_4', value: '10000')
Setting.create(key: 'price_range_1_value', value: 120000)
Setting.create(key: 'price_range_2_value', value: 100000)
Setting.create(key: 'price_range_3_value', value: 90000)
Setting.create(key: 'price_range_4_value', value: 80000)
Setting.create(key: 'packs', value: '0.01, 0.02, 0.05, 0.1')
Setting.create(key: 'active', value: 1)
Setting.create(key: 'max', value: 30000)
Setting.create(key: 'min', value: 1000)
Setting.create(key: 'first_max', value: 3000)
Setting.create(key: 'first_min', value: 500)
Setting.create(key: 'premium', value: 0.1)
Setting.create(key: 'auto', value: 0)
Setting.create(key: 'interval', value: 2)
Setting.create(key: 'phone', value: '')
