class Admin::DashboardController < Admin::BaseController

  def index
    @btc_price = Setting.where(key: 'btc_price')[0]

    @pending_orders = Order.where(submitted: true, completed: false)
    @new_orders = Order.where(submitted: false, completed: false)
  end

end
