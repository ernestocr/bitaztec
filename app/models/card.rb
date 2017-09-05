class Card < ApplicationRecord
  belongs_to :account
  has_and_belongs_to_many :payment_methods

  validates :number, length: { minimum: 16 }

  def name
    number
  end

  def number_of_orders
    Order.where(card_id: self.id).count
  end

  def is_being_used
    self.payment_methods.count > 0
  end
end
