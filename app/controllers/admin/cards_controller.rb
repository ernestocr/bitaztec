class Admin::CardsController < Admin::BaseController

  before_action :set_card, only: [:update, :destroy]

  def create
    @card = Card.create(card_params)
    if @card.save
      flash[:notice] = 'Tarjeta agregada.'
    else
      flash[:error] = 'Hubo un error al crear la tarjeta.'
    end
    redirect_to edit_admin_bank_account_path(@card.account.bank, @card.account)
  end

  def update
    @card.update_attributes(card_params)
    flash[:notice] = 'Los datos de la tarjeta han sido guardados.'
    redirect_to edit_admin_bank_account_path(@card.account.bank, @card.account)
  end

  def destroy
    @card.destroy
    flash[:notice] = 'La tarjeta fue eliminada.'
    redirect_to edit_admin_bank_account_path(@card.account.bank, @card.account)
  end

  private

    def card_params
      params.require(:card).permit(:account_id, :number, :active)
    end

    def set_card
      @card = Card.find(params[:id])
    end
end
