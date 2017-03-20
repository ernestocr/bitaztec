class MessagesController < ApplicationController

  before_action :authenticate_user!

  def create
    message = Message.new(message_params)
    message.user = current_user
    
    # whoever wrote it, also read it
    message.admin_read = current_user.admin?
    message.user_read  = !current_user.admin?

    message.save!
    
    if current_user.admin?
      # if admin created message, send notif. to user
      UserMailer.new_message(message).deliver_later
    else
      # AdminMailer.new_message(message)
    end

    redirect_to :back
  end

  private

    def message_params
      params.require(:message).permit(:body, :order_id)
    end

end
