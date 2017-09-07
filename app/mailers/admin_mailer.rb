class AdminMailer < ApplicationMailer

  # get list of emails form all admins
  default to: Proc.new { User.where(admin: true, receives_notifs: true).pluck(:email) },
          from: 'BitAztec <admin@bitaztec.com>'

  def new_order(order)
    @order = order
    @price = view_context.number_to_currency @order.price, precision: 2, separator: '.'
    mail(subject: "Pedido nuevo, #{@order.amount} a #{@price}")
  end

  def order_submitted(order)
    @order = order
    @price = view_context.number_to_currency @order.price, precision: 2, separator: '.'
    mail(subject: "Pedido pagado, #{@order.amount} a #{@price}")
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
