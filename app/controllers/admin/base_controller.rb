class Admin::BaseController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_only
  before_action :btc_price_set?

  layout 'admin'

  private

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
