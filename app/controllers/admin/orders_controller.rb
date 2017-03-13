class Admin::OrdersController < Admin::BaseController
before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    # only get new/pending orders
    @new_orders = Order.where(submitted: false, completed: false)
    @pending_orders = Order.where(submitted: true, completed: false)
  end

  def history
    @orders = Order.all
  end

  def show
    last_msgs = @order.messages.where(admin_read: false)
    if last_msgs
      last_msgs.each do |msg|
        msg.update_attributes(admin_read: true)
      end
    end
  end

  # probably won't need an edit page
  # def edit
  # end

  def update
    # if the order is now complete
    if params[:complete]
      @order.update_attributes(
        completed: true, 
        authorized_by: current_user.id,
        completed_at: DateTime.current 
      )
      
      redirect_to admin_order_path(@order), 
        flash: { notice: "El pedido ##{@order.id} fue completado." }
    elsif params[:reject]
      @order.update_attributes(submitted: false)
      redirect_to admin_order_path(@order)
    end
  end

  def destroy
    # cancel an order
    # don't forget to notify user
    @order.destroy
    redirect_to admin_orders_path, flash: { notice: 'El pedido fue cancelado.' }
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

end
