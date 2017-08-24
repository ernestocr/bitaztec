class Account < ApplicationRecord

  default_scope { order(created_at: :desc) }

  validates :number, length: { minimum: 10 }
  validates :clabe, length: { is: 18 }, allow_blank: true

  validates :holder, presence: true
  validates :active, presence: true
  validates :bank, presence: true

  belongs_to :bank

  has_many :cards, dependent: :destroy
end
