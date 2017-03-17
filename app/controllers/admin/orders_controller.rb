class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    # only get new/pending orders
    @new_orders = Order.where(submitted: false, completed: false)
    @pending_orders = Order.where(submitted: true, completed: false)
  end

  def history
    @orders = Order.where(completed: true).paginate(page: params[:page], per_page: 30)
  end

  def show
    read_msgs @order    
  end

  def update
    if params[:complete]
      # if the order is now complete
      @order.update_attributes(
        completed: true, 
        authorized_by: current_user.id,
        completed_at: DateTime.now.utc 
      )
      
      redirect_to admin_order_path(@order), 
        flash: { notice: "El pedido ##{@order.id} fue completado." }
    
    elsif params[:reject]
      # if not, then it's being rejected
      @order.update_attributes(submitted: false)
      redirect_to admin_order_path(@order)
    end
  end

  def destroy
    @order.destroy
    redirect_to admin_orders_path, flash: { notice: 'El pedido fue cancelado.' }
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end
    
    # update :admin_read
    def read_msgs order
      last_msgs = @order.messages.where(admin_read: false)
      last_msgs.each do |msg|
        msg.update_attributes(admin_read: true)
      end
    end

end
