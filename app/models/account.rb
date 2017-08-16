class Account < ApplicationRecord

  default_scope { order(created_at: :desc) }

  validates :number, length: { minimum: 10 }, allow_blank: true
  validates :clabe, length: { is: 18 }, allow_blank: true
  # validates :card, length: { is: 16 }, allow_blank: true

  validates :holder, presence: true
  validates :active, presence: true
  validates :bank, presence: true

  belongs_to :bank

end
