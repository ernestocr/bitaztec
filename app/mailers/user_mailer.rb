class UserMailer < ApplicationMailer

  def order_complete(order)
    @order = order
    @user  = order.user
    mail(to: @user.email, subject: 'Order complete!')
  end

  def order_expired(order)
    @order = order
    @user  = order.user
    mail(to: @user.email, subject: 'Order expired.')
  end

  def order_denied(order)
    @order = order
    @user  = order.user
    mail(to: @user.email, subject: 'Order denied.')
  end

  def new_message(message)
    @msg = message
  end

end
