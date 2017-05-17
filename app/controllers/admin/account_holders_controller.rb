class Admin::AccountHoldersController < Admin::BaseController

  before_action :set_account_holder, only: [:update, :destroy]

  def index
    @account_holders = AccountHolder.all
    # same page new object
    @account_holder  = AccountHolder.new
  end

  def create
    # same page
    @account_holders = AccountHolder.all

    @account_holder = AccountHolder.new(account_holder_params)
    if @account_holder.save
      redirect_to admin_account_holders_path,
        flash: { notice: 'Nuevo dueño de cuenta creado.' }
    else
      render :index
    end
  end

  def update
    # same page
    @account_holders = AccountHolder.all

    if @account_holder.update_attributes(account_holder_params)
      redirect_to admin_account_holders_path,
        flash: { notice: 'Dueño de cuenta actualizado.' }
    else
      render :index
    end
  end

  def destroy
    @account_holder.destroy
    redirect_to admin_account_holders_path
  end

  private

    def account_holder_params
      params.require(:account_holder).permit(:name)
    end

    def set_account_holder
      @account_holder = AccountHolder.find(params[:id])
    end

end
