class Card < ApplicationRecord
  belongs_to :account
  has_and_belongs_to_many :payment_methods

  validates :number, length: { minimum: 16 }
end
