class Admin::SettingsController < Admin::BaseController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  def index
    @settings = Setting.all
  end

  def show
    redirect_to admin_settings_path
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
      redirect_to admin_settings_path, notice: 'La configuración fue actualizada.'
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
