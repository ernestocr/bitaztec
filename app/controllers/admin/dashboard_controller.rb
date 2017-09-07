class Admin::DashboardController < Admin::BaseController

  def index
    # grab both pending and new orders
    @pending_orders = Order.where(submitted: true, completed: false, removed: false)
    @new_orders = Order.where(submitted: false, completed: false, removed: false)

    # select all messages that the admin has not read
    @messages = Message.where(admin_read: false)
  end

  def admins
    @admins = User.where(admin: true)
  end

end
