class Bank < ApplicationRecord

  default_scope { order(created_at: :desc) }
  validates :name, presence: true
  
  has_many :accounts, dependent: :destroy

  mount_uploader :image, ImageUploader
end
