class UserMailerPreview < ActionMailer::Preview

  def order_complete
    order = Order.first
    UserMailer.order_complete(order)
  end

  def order_expired
    order = Order.first
    UserMailer.order_expired(order)
  end
  
  def order_denied
    order = Order.first
    UserMailer.order_denied(order)
  end

end
