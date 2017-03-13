class Admin::AccountHoldersController < Admin::BaseController

  def index
    @account_holders = AccountHolder.all
    @account_holder  = AccountHolder.new
  end

  def create
    @account_holder = AccountHolder.new(account_holder_params)
    if @account_holder.save
      redirect_to admin_account_holders_path,
        flash: { notice: 'Nuevo dueño de cuenta creado.' }
    else
      render :index
    end
  end

  def update
    @account_holder = AccountHolder.find(params[:id])
    if @account_holder.update_attributes(account_holder_params)
      redirect_to admin_account_holders_path,
        flash: { notice: 'Dueño de cuenta actualizado.' }
    else
      render :index
    end
  end

  def destroy
    @account_holder = AccountHolder.find(params[:id])
    @account_holder.destroy
    redirect_to admin_account_holders_path
  end

  private

    def account_holder_params
      params.require(:account_holder).permit(:name)
    end

end
