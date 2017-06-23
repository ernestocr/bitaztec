class Admin::SettingsController < Admin::BaseController
  before_action :set_setting, only: [:edit, :update, :destroy]

  def index
    @settings = Setting.all
  end

  def new
    @setting = Setting.new
  end

  def edit
  end

  def create
    @setting = Setting.new(setting_params)

    if @setting.save
      redirect_to admin_settings_path, notice: 'Una configuración fue creada.'
    else
      render :new
    end
  end

  def update
    if @setting.update(setting_params)
      # admin can update "precio" from dashboard
      if params[:dashboard] == 'true'
        redirect_to admin_path
      else
        redirect_to admin_settings_path, notice: 'La configuración fue actualizada.'
      end
    else
      render :edit
    end
  end

  def destroy
    @setting.destroy
    redirect_to admin_settings_path, notice: 'La configuración fue borrada.'
  end

  private

    def set_setting
      @setting = Setting.find(params[:id])
    end

    def setting_params
      params.require(:setting).permit(:key, :value)
    end
end
