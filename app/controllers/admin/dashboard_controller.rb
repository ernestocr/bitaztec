class Admin::DashboardController < Admin::BaseController

  def index
    # we grab the record, not the value
    #@btc_price = Setting.where(key: 'price')[0]

    # grab both pending and new orders
    @pending_orders = Order.where(submitted: true, completed: false, removed: false)
    @new_orders = Order.where(submitted: false, completed: false, removed: false)

    # select all messages that the admin has not read
    @messages = Message.where(admin_read: false)
  end

end
