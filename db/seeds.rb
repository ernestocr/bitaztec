# Required Settings
Setting.destroy_all

Setting.create(key: 'price', value: 30000)
Setting.create(key: 'price_range_1', value: '0')
Setting.create(key: 'price_range_2', value: '500')
Setting.create(key: 'price_range_3', value: '1000')
Setting.create(key: 'price_range_4', value: '10000')
Setting.create(key: 'price_range_1_value', value: 120000)
Setting.create(key: 'price_range_2_value', value: 110000)
Setting.create(key: 'price_range_3_value', value: 100000)
Setting.create(key: 'price_range_4_value', value: 90000)
Setting.create(key: 'price_range_1_premium', value: 0)
Setting.create(key: 'price_range_2_premium', value: 0)
Setting.create(key: 'price_range_3_premium', value: 0)
Setting.create(key: 'price_range_4_premium', value: 0)

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


