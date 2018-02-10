class Admin::SettingsController < Admin::BaseController
  before_action :set_setting, only: :update

  def index
    @price = Setting.where(key: 'price').first
    
    @price_range_1 = Setting.where(key: 'price_range_1').first
    @price_range_2 = Setting.where(key: 'price_range_2').first
    @price_range_3 = Setting.where(key: 'price_range_3').first
    @price_range_4 = Setting.where(key: 'price_range_4').first
    
    @price_range_1_value = Setting.where(key: 'price_range_1_value').first
    @price_range_2_value = Setting.where(key: 'price_range_2_value').first
    @price_range_3_value = Setting.where(key: 'price_range_3_value').first
    @price_range_4_value = Setting.where(key: 'price_range_4_value').first

    @price_range_1_premium = Setting.where(key: 'price_range_1_premium').first
    @price_range_2_premium = Setting.where(key: 'price_range_2_premium').first
    @price_range_3_premium = Setting.where(key: 'price_range_3_premium').first
    @price_range_4_premium = Setting.where(key: 'price_range_4_premium').first
    
    @packs = Setting.where(key: 'packs').first
    @home_packs = Setting.where(key: 'home_packs').first
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

  def update_all
    params[:settings].each do |id, v|
      Setting.find(id).update_attributes({value: v})
    end
    render json: true
  end

  private

    def set_setting
      @setting = Setting.find(params[:id])
    end

    def setting_params
      params.require(:setting).permit(:key, :value)
    end
end
