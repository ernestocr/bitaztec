class AdminMailer < ApplicationMailer

  # get list of emails form all admins
  default to: Proc.new { User.where(admin: true).pluck(:email) },
          from: 'BitAztec <admin@bitaztec.com>'

  def new_order(order)
    @order = order
    mail(subject: "Pedido nuevo, #{@order.amount} a #{number_to_currency @order.price}")
  end

  def order_submitted(order)
    @order = order
    mail(subject: "Pedido pagado, #{@order.amount} a #{number_to_currency @order.price}")
  end

  def order_cancelled
    mail(subject: "Pedido cancelado")
  end

  def new_message(message)
    @msg = message
    @order = @msg.order
    mail(subject: "Mensaje nuevo")
  end

end
