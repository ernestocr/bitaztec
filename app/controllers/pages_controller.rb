class PagesController < ApplicationController

  # static pages

  def home
    @btc_price = Setting.btc_price
  end

  def howto
  end

  def faq
  end

  def contact
  end

  def legal
  end

  # TESTING GODADDY SMTP EMAIL RELAY
  def godaddy
    user = User.first
    UserMailer.godaddy(user).deliver_now
    render text: 'check logs to see if email went through'
  end

end
