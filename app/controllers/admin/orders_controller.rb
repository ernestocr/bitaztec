class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    # only get new/pending orders
    @new_orders = Order.where(submitted: false, completed: false, removed: false)
    @pending_orders = Order.where(submitted: true, completed: false, removed: false)
    @expired_orders = Order.
                        where(submitted: false, completed: false, removed: true).
                        where('created_at > ?', Time.now - 1.day)
  end

  def history
    @orders = Order.where(completed: true).paginate(page: params[:page], per_page: 30)
  end

  def show
    # mark all messages as admin_read
    read_msgs @order
    if !@order.account_id.blank?
      @account = Account.unscoped.find(@order.account_id)
    end
    if !@order.card_id.blank?
      @card = Card.unscoped.find(@order.card_id)
    else
      @card = nil
    end
  end

  def update
    if params[:complete]
      # if the order is now complete
      @order.update_attributes(
        completed: true,
        authorized_by: current_user.id,
        completed_at: DateTime.now.utc
      )

      # notify user
      Notification.create(recipient: @order.user, action: 'completed', notifiable: @order)
      UserMailer.order_complete(@order).deliver_later

      redirect_to admin_order_path(@order),
        flash: { notice: "El pedido ##{@order.id} fue completado." }

    elsif params[:reject]
      # if not, then it's being rejected
      tolerance = DateTime.current + 1.hour
      @order.update_attributes(submitted: false, expires_at: tolerance)

      # notify user
      Notification.create(recipient: @order.user, action: 'rejected', notifiable: @order)
      UserMailer.order_denied(@order).deliver_later

      redirect_to admin_order_path(@order)
    else
      @order.update_attributes(order_params)
      redirect_to admin_order_path(@order)
    end
  end

  def destroy
    Notification.where(notifiable: @order).each do |notif|
      notif.destroy
    end
    @order.destroy
    #@order.update_attributes(removed: true)
    Notification.create(recipient: @order.user, action: 'cancelled', notifiable: @order)
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

    def order_params
      params.require(:order).permit(:confirmed_account_id, :confirmed_card_id)
    end

end
