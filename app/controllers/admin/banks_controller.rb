class Admin::BanksController < Admin::BaseController

  before_action :set_bank, except: [:index, :new, :create]

  def index
    @banks = Bank.all
  end

  def show
  end

  def edit
  end

  def new
    @bank = Bank.new
  end

  def create
    @bank = Bank.create(bank_params)
    if @bank.save
      redirect_to admin_banks_path, notice: "Banco '#{@bank.name}' agregado."
    else
      render :new
    end
  end

  def update
    if @bank.update_attributes(bank_params)
      redirect_to admin_banks_path, notice: "Los datos de '#{@bank.name}' fueron actualizados."
    else
      render :edit
    end
  end

  def destroy
    if @bank.destroy
      redirect_to admin_banks_path, notice: "El banco '#{@bank.name} fue eliminado.'"
    end
  end

  def toggle
    @bank.toggle!(:active)
    redirect_to :back
  end

  private

    def set_bank
      @bank = Bank.find(params[:id])
    end

    def bank_params
      params.require(:bank).permit(:name, :active, :image)
    end

end
