class PaymentMethod < ApplicationRecord

  default_scope { order(created_at: :desc) }
  
  validates :name, presence: true
  validates :method, presence: true
  validates :instructions, presence: true
  validates :active, presence: true
  validates :schedule, presence: true

  has_many :orders

end
