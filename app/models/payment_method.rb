class PaymentMethod < ApplicationRecord

  default_scope { order(created_at: :desc) }
  
  validates :name, presence: true
  validates :method, presence: true
  validates :account, presence: true

  has_many :orders

end
