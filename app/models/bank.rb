class Bank < ApplicationRecord

  validates :name, presence: true
  validates :active, presence: true

end
