class Admin::SettingsController < Admin::BaseController
  before_action :set_setting, only: :update

  def index
    @price = Setting.where(key: 'price').first
    @packs = Setting.where(key: 'packs').first
    @active = Setting.where(key: 'active').first
    @max = Setting.where(key: 'max').first
    @min = Setting.where(key: 'min').first
    @first_max = Setting.where(key: 'first_max').first
    @first_min = Setting.where(key: 'first_min').first
    @premium = Setting.where(key: 'premium').first
    @auto = Setting.where(key: 'auto').first
    @interval = Setting.where(key: 'interval').first
    @phone = Setting.where(key: 'phone').first
  end

  def update
    if @setting.update(setting_params)
      redirect_to admin_settings_path, notice: 'La configuración fue actualizada.'
    else
      render :edit
    end
  end

  private

    def set_setting
      @setting = Setting.find(params[:id])
    end

    def setting_params
      params.require(:setting).permit(:key, :value)
    end
end
