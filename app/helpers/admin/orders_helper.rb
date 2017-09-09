module Admin::OrdersHelper

  def btc_amount(n)
    n.round(5)
  end

end
