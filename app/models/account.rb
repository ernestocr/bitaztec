class Account < ApplicationRecord

  default_scope { order(created_at: :desc) }
  default_scope { where(deprecated: false) }

  validates :number, length: { minimum: 10 }
  validates :clabe, length: { is: 18 }, allow_blank: true

  validates :holder, presence: true
  validates :active, presence: true
  validates :bank, presence: true

  belongs_to :bank
  has_many :cards, dependent: :destroy
  has_and_belongs_to_many :payment_methods

  def name
    "#{self.bank.name} - #{self.number}"
  end

  def number_of_orders
    Order.where(account_id: self.id).count
  end

  def is_being_used
    self.payment_methods.count > 0
  end

end
