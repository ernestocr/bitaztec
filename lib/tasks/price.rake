require 'net/http'
require 'json'
require 'action_view/helpers'
extend ActionView::Helpers

namespace :price do

  desc "Get current price in MXN from CoinDesk and update price"
  task update: :environment do
    # Check if automatic updates are on
    auto_update = Setting.where(key: 'auto').first
    next if auto_update.value != '1'

    # Get BPI current price
    url = 'https://api.coindesk.com/v1/bpi/currentprice/mxn.json'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    market_price = data["bpi"]["MXN"]["rate_float"]

    # Update database, with premium
    premium = Setting.where(key: 'premium').first.value.to_f
    updated_price = (market_price*(1 + premium)).round()
    Setting.where(key: 'price').first.update_attributes(value: updated_price)
    puts "Updated price to " + number_to_currency(updated_price, separator: '.')
  end

end
