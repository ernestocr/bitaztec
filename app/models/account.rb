class Account < ApplicationRecord

  belongs_to :bank
  
  validates :number, presence: true
  validates :holder, presence: true
  validates :active, presence: true
  validates :bank, presence: true

end
