module Admin::OrdersHelper

  def btc_amount(n)
    n.round(5)
  end

  def accounts_collection(add_empty = nil)
  	accounts = Account.all.collect { |a| [a.name, a.id] }
  	accounts << ['Otro', ''] if add_empty
  	return accounts
  end

  def cards_collection(add_empty = nil)
  	cards = Card.all.collect { |a| [a.number, a.id] }
  	cards << ['Otro', ''] if add_empty
  	return cards
  end

end
