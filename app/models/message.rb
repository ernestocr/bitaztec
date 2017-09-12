class Message < ApplicationRecord

  default_scope { order(created_at: :asc) }
  belongs_to :order
  belongs_to :user

  validates :body, presence: true
  validates :user, presence: true
end
