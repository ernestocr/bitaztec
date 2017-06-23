class Admin::BaseController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_only
  before_action :btc_price_set?
  before_action :system_active_set?
  before_action :set_notifications, except: [:create, :update, :destroy]

  layout 'admin'

  private

    def set_notifications
      pending_orders = Order.where(submitted: true, completed: false, removed: false).count
      new_orders = Order.where(submitted: false, completed: false, removed: false).count
      messages = Message.where(admin_read: false).count

      # simple notification count
      @notifications = pending_orders + new_orders + messages
    end

    def btc_price_set?
      if !Setting.precio
        flash[:alert] = 'El precio del Bitcoin no está! Ve a configuración y agrega "precio".'
      end
    end

    def system_active_set?
      if !Setting.activo
        flash[:alert] = 'El sitio está activo por default, vaya a configuración para asegurarse de esto.'
      elsif Setting.activo == 'inactivo'
        flash[:alert] = 'El sitio está inactivo. Puedes activarlo en el panel de configuración.'
      end
    end

    def admin_only
      if !current_user.admin?
        redirect_to root_path, notice: 'Acceso no autorizado.'
      end
    end

end
