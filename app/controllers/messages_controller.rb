class MessagesController < ApplicationController

  before_action :authenticate_user!

  def create
    order = Order.find(params[:message][:order_id])
    message = order.messages.new(message_params)
    message.user = current_user
    
    if current_user.admin?
      message.admin_read = true
    else
      message.user_read = true
    end

    message.save!
    redirect_to :back
  end

  private

  def message_params
    params.require(:message).permit(:body, :order_id)
  end

end
