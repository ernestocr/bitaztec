class Bank < ApplicationRecord

  default_scope { order(created_at: :desc) }
  
  validates :name, presence: true

  has_many :accounts
  has_and_belongs_to_many :payment_methods

  mount_uploader :image, ImageUploader

end
