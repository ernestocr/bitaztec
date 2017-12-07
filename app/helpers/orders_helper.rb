module OrdersHelper

  def get_price amount
    @btc_prices.reverse.each do |price|
      if amount > price[:minb]
        return price[:price]
      end
    end
  end

end
