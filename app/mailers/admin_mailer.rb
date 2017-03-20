class AdminMailer < ApplicationMailer

  default to: Proc.new { User.where(admin: true).pluck(:email) },
          from: 'notification@bitaztec.com'

  def new_order(order)
    @order = order
    mail(subject: "Pedido nuevo, #{@order.amount} a #{@order.price}")
  end
  
  def order_submitted(order)
    @order = order
    mail(subject: "Pedido pagado, #{@order.amount} a #{@order.price}")
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
