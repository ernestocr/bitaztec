class Admin::BaseController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_only
  before_action :btc_price_set?
  before_action :set_notifications, except: [:create, :update, :destroy]

  layout 'admin'

  private

    def set_notifications
      pending_orders = Order.where(submitted: true, completed: false).count
      new_orders = Order.where(submitted: false, completed: false).count
      messages = Message.where(admin_read: false).count
      @notifications = pending_orders + new_orders + messages
    end

    def btc_price_set?
      if !Setting.btc_price
        flash[:alert] = 'El precio del Bitcoin no está! Ve a configuración y agrega "btc_price".'
      end
    end

    def admin_only
      if !current_user.admin?
        redirect_to root_path, notice: 'Acceso no autorizado.'
      end
    end

end
