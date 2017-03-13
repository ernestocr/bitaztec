class AccountHolder < ApplicationRecord

  default_scope { order(created_at: :desc) }
  validates :name, presence: true

end
