class MessagesController < ApplicationController

  before_action :authenticate_user!

  def create
    @message = Message.new(message_params)
    @message.user = current_user

    # whoever wrote it, also read it
    @message.admin_read = current_user.admin?
    @message.user_read  = !current_user.admin?

    @message.save!

    if current_user.admin?
      # if admin created message, send notif. to user
      Notification.create(recipient: @message.order.user, action: 'new message', notifiable: @message.order)
      UserMailer.new_message(@message).deliver_later
    else
      # TODO: send notif to all admins?
      User.where(admin: true).each do |admin|
        Notification.create(recipient: admin, action: 'new message', notifiable: @message.order)
      end
      AdminMailer.new_message(@message).deliver_later
    end

    if request.xhr?
      render partial: 'shared/message', locals: { msg: @message }
    else
      redirect_to :back
    end
  end

  def index
    @order = Order.find(params[:order])
    render partial: 'shared/message_feed'
  end

  private

    def message_params
      params.require(:message).permit(:body, :order_id)
    end

end
