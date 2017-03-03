class OrdersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_btc_price, only: [:new, :create]

  def index
    # show user's order history
    @orders = current_user.orders.all
  end

  def show
    last_msgs = @order.messages.where(user_read: false)
    if last_msgs
      last_msgs.each do |msg|
        msg.update_attributes(user_read: true)
      end
    end
  end

  def new
    # can't make new order if they have one open
    if pending_order?
      redirect_to current_user.orders.first,
        flash: { notice: 'Tienes un pedido pendiente.' }
    end
    @order = current_user.orders.new
  end

  def edit
    # for now redirect to index
    redirect_to orders_path
  end

  def create
    # prevent savy users from _posting_ another
    # order while having one open
    if !pending_order?
      @order = current_user.orders.new(order_params)
      @order.price = @btc_price
      if @order.payment_method
        @order.expires_in = @order.payment_method.expires
      end

      if @order.save
        redirect_to @order, notice: 'Pedido enviado exitosamente.'
      else
        render :new
      end
    end
  end

  def update
    # update order status
    # submitted: true
    if @order.update(order_params)
      redirect_to @order, notice: 'Pedido fue actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    # cancel an order
    @order.destroy
    redirect_to orders_url, notice: 'Tu pedido fue cancelado.'
  end

  private
    
    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:amount, :price, :address, :submitted, :payment_method_id)
    end

    def set_btc_price
      # for now just set it without checking
      @btc_price = Setting.btc_price
    end

    def pending_order?
      # if the user has an open order
      current_user.active_orders_count > 0
    end

end
