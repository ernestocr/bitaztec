class Admin::AccountsController < Admin::BaseController

  before_action :set_bank
  before_action :set_account, only: [:edit, :update, :destroy, :toggle]

  def index
    @accounts = @bank.accounts.all
  end

  def new
    @account = @bank.accounts.new
  end

  def edit
    @account_holders = AccountHolder.all
  end

  def create
    @account = @bank.accounts.create(account_params)
    if @account.save
      flash[:notice] = "La cuenta fue creada exitosamente."
      redirect_to edit_admin_bank_account_path @bank.id, @account.id 
    else
      render :new
    end
  end

  def update
    if params[:account][:deprecated] == "true"
      @account.update_attributes(deprecated: true)
      return redirect_to admin_banks_path(@bank), notice: 'La cuenta ya no aparecerá'
    end
    
    if @account.update_attributes(account_params)
      flash[:notice] = "Los cambios fueron guardados."
      redirect_to edit_admin_bank_account_path @bank, @account 
    else
      render :edit
    end
  end

  def toggle
    # direct db update
    @account.toggle!(:active)
    redirect_to :back
  end

  def destroy
    @account.destroy
    redirect_to admin_bank_accounts_path @bank
  end

  private

    def set_bank
      @bank = Bank.find(params[:bank_id])
    end

    def set_account
      @account = @bank.accounts.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:number, :clabe, :holder, :bank_id, :active, :deprecated)
    end

end
