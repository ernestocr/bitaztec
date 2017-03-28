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

  def new_message
    msg = Message.first
    UserMailer.new_message(msg)
  end

  def godaddy
    user = User.first
    UserMailer.godaddy(user)
  end

end
