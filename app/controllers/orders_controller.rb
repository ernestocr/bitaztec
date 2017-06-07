class OrdersController < ApplicationController

  before_action :authenticate_user!

  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_btc_price, only: [:new, :create]

  # can't access new, create if they have a pending order
  before_action :has_pending_order, only: [:new, :create]

  # user's main page
  def index
    @history = current_user.orders.where(completed: true, removed: false)
    @order = current_user.orders.where(completed: false, removed: false).first

    # if the user has a pending order, has not submitted evidence
    # and is expired, then delete the order, and notify the user
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
  end

  def new
    @order = current_user.orders.new
    @methods = PaymentMethod.where(active: true, deprecated: false)
  
    @min = Setting.min
    @max = Setting.max
  end

  def create
    @order = current_user.orders.new(order_params)
    # set price from db, not from a form
    @order.price = @btc_price

    if @order.save
      AdminMailer.new_order(@order).deliver_later
      redirect_to @order, notice: 'Tu pedido fue creado exitosamente.'
    else
      render :new
    end
  end

  def update
    # called only after image upload and address submition
    if order_params[:attachments] == nil
      redirect_to @order, alert: 'Debes subir la evidencia de pago.'
    elsif order_params[:address] == nil
      redirect_to @order, alert: 'Debes poner un domicilio válido.'
    elsif @order.update(order_params)
      AdminMailer.order_submitted(@order).deliver_later
      redirect_to @order, notice: 'Tu pedido fue actualizado exitosamente.'
    end
  end

  def destroy
    # destroy all current notifications
    Notification.where(notifiable_id: @order.id).delete_all
    
    # destroy order
    #@order.destroy
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
        {attachments: []}
      )
    end

    def set_btc_price
      @btc_price = Setting.btc_price
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

end
