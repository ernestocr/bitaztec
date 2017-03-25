class NotificationsController < ApplicationController

  before_action :authenticate_user!

  def index
    # gets called for every user
    @notifications = Notification.where(recipient: current_user).unread
  end

  def mark_as_read
    # marks ALL notifications read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end

  def count
    # simply json return the number of notifications
    @count = Notification.where(recipient: current_user).unread.count
    render json: { notifications: @count }
  end

end
