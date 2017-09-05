class OrdersController < ApplicationController

  before_action :authenticate_user!

  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_btc_price, only: [:new, :create]

  # check if SITE is live and selling
  before_action :system_ok, only: [:new, :create, :update]
  
  # redirect to order if the user has an open order
  before_action :has_pending_order, only: [:new, :create]

  # user's account page
  def index
    @history = current_user.orders.where(completed: true, removed: false)
    @order = current_user.orders.where(completed: false, removed: false).first

    # if the user has a pending order, has not submitted evidence
    # and is expired, then 'delete' the order, and notify the user
    if @order and @order.expired and !@order.submitted
      Notification.create(
        recipient: @order.user,
        action: 'expired',
        notifiable: @order
      )
      #@order.destroy
      @order.update_attributes(removed: true)
      @order = nil
    end
  end

  # order receipt
  def show
    # if the GET request came from a notification click
    if params[:clear_notifs]
      Notification.where(notifiable_id: @order.id).update_all(read_at: Time.zone.now)
    end

    # mark all messages as read
    read_msgs @order
    
    # it's annoying having to write @order.payment_methods.each...
    @pm = @order.payment_method
  end

  def new
    @order = current_user.orders.new
    
    # set the current global variables and options
    @methods = PaymentMethod.where(active: true, deprecated: false)
    @min = Setting.min
    @max = Setting.max
    @first_min = Setting.first_min
    @first_max = Setting.first_max
  end

  def create
    @order = current_user.orders.new(order_params)
    # set price from db always
    @order.price = @btc_price

    if @order.save
      AdminMailer.new_order(@order).deliver_later
      redirect_to @order, notice: 'Tu pedido fue creado exitosamente.'
    else
      render :new
    end
  end

  def update
    # not pretty but the most user intuitive way I could come up with...
    if params[:step] == 'image'
      # user uploaded an image, just save and reload
      if order_params[:attachments] == nil
        redirect_to @order, alert: 'Debes subir la evidencia de pago en un formato válido.'
      else
        @order.update(order_params)
        redirect_to @order, alert: 'Excelente. Ahora solo agrega tu domicilio wallet para completar el pedido.'
      end 
    else
      # user added his wallet address and therefore completed his payment
      if order_params[:address] == nil
        redirect_to @order, alert: 'Debes poner un domicilio válido.'
      elsif @order.update(order_params)
        AdminMailer.order_submitted(@order).deliver_later
        redirect_to @order, notice: 'Tu pago ahora está en proceso de revisión.'
      end
    end
  end

  def destroy
    # destroy all current notifications
    Notification.where(notifiable_id: @order.id).delete_all

    # destroy order
    @order.update_attributes(removed: true)

    # notify the admin that the order was cancelled
    AdminMailer.order_cancelled().deliver_later
    redirect_to orders_url, notice: 'Tu pedido fue cancelado.'
  end

  private

    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def order_params
      params.require(:order).permit(
        :amount, :price, :address,
        :submitted, :payment_method_id,
        {attachments: []}, :account_id, :card_id
      )
    end

    def set_btc_price
      @btc_price = Setting.price
    end

    # if he has a pending order, redirect to it
    def has_pending_order
      if current_user.active_orders_count > 0
        redirect_to current_user.orders.first,
          flash: { notice: 'Tienes un pedido pendiente.' }
      end
    end

    # update :user_read
    def read_msgs order
      last_msgs = order.messages.where(user_read: false)
      last_msgs.each do |msg|
        msg.update_attributes(user_read: true)
      end
    end

    def system_ok
      if Setting.active != '1'
        render 'orders/not_active'
      end
    end

end
