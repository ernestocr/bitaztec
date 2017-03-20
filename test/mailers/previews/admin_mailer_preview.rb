class AdminMailerPreview < ActionMailer::Preview

  def new_order
    order = Order.first
    AdminMailer.new_order(order)
  end

  def order_submitted
    order = Order.first
    AdminMailer.order_submitted(order)
  end

  def order_cancelled
    order = Order.first
    AdminMailer.order_cancelled(order)
  end
  
  def new_message
    msg = Message.first
    AdminMailer.new_message(msg)
  end

end
