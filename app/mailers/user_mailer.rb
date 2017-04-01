class UserMailer < ApplicationMailer

  def order_complete(order)
    @order = order
    @user  = order.user
    mail(to: @user.email, subject: 'Pedido completado')
  end

  def order_expired(order)
    @order = order
    @user  = order.user
    mail(to: @user.email, subject: 'Pedido expirado')
  end

  def order_denied(order)
    @order = order
    @user  = order.user
    mail(to: @user.email, subject: 'Pedido rechazado')
  end

  def new_message(message)
    @msg = message
    @order = @msg.order
    @user = @order.user
    mail(to: @user.email, subject: 'Mensaje nuevo')
  end

  def godaddy(user)
    @user = user
    mail(to: @user.email, subject: 'working')
  end

end
