class PagesController < ApplicationController

  # Static pages
  # Can change route names later

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

end
