class Account < ApplicationRecord

  default_scope { order(created_at: :desc) }
  
  validates :number, presence: true
  validates :holder, presence: true
  validates :active, presence: true
  validates :bank, presence: true

  belongs_to :bank

end
