class Card < ApplicationRecord
  belongs_to :account

  validates :number, length: { minimum: 16 }
end
