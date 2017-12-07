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

    puts "Getting market price from Coindesk..."

    # Get BPI current price
    url = 'https://api.coindesk.com/v1/bpi/currentprice/mxn.json'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    market_price = data["bpi"]["MXN"]["rate_float"]

    puts "Current market price is: #{market_price}, now updating settings..."

    # Update database, with premium
    # premium = Setting.where(key: 'premium').first.value.to_f
    # updated_price = (market_price*(1 + premium)).round()
    # Setting.where(key: 'price').first.update_attributes(value: updated_price)
    # puts "Updated price to " + number_to_currency(updated_price, separator: '.')

    p1_premium = Setting.price_range_1_premium
    p2_premium = Setting.price_range_2_premium
    p3_premium = Setting.price_range_3_premium
    p4_premium = Setting.price_range_4_premium

    p1 = Setting.where(key: 'price_range_1_value').first
    p2 = Setting.where(key: 'price_range_2_value').first
    p3 = Setting.where(key: 'price_range_3_value').first
    p4 = Setting.where(key: 'price_range_4_value').first

    premiums = [p1_premium, p2_premium, p3_premium, p4_premium]
    prices = [p1, p2, p3, p4]

    prices.each_with_index do |price, i|
        premium = premiums[i].to_f
        next if premium > 1

        updated_price = (market_price*(1 + premium)).round()
        if price.update_attributes({value: updated_price})
            puts "Updated price range #{i+1} to #{number_to_currency(updated_price, separator: '.')}"
        else
            puts "Error updating price range #{i+1}"
        end
    end
  end

end
