class OrdersController < ApplicationController
  
  before_action :authenticate_user!
  
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_btc_price, only: [:new, :create]
  
  before_action :has_pending_order, only: [:new, :create]

  def index
    @orders = current_user.orders.all
  end

  def show
    read_msgs @order    
  end

  def new
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.price = @btc_price
    
    if @order.save
      redirect_to @order, notice: 'Pedido enviado exitosamente.'
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Pedido fue actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
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
