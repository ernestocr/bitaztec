class PagesController < ApplicationController

  # static pages

  def home
    @btc_display_price = Setting.display_price
  end

  def howto
  end

  def faq
  end

  def contact
    @contact_form = ContactForm.new
  end

  def send_message
    @contact_form = ContactForm.new(contact_form_params)
    if @contact_form.deliver
      redirect_to contact_path, notice: 'El mensaje fue enviado!'
    else
      redirect_to contact_path, alert: 'Hubo un error. Intente de nuevo.'
    end
  end

  def legal
  end

  private

    def contact_form_params
      params.require(:contact_form).permit(:name, :email, :message)
    end

end
