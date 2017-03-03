class Bank < ApplicationRecord

  has_many :accounts

  validates :name, presence: true
  validates :active, presence: true

end
