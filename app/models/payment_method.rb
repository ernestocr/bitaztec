class PaymentMethod < ApplicationRecord

  default_scope { order(created_at: :desc) }
  default_scope { where(deprecated: false) }
  
  validates :name, presence: true
  validates :method, presence: true
  validates :instructions, presence: true
  validates :schedule, presence: true
  validates :banks, presence: true

  has_many :orders
  has_and_belongs_to_many :banks

end
