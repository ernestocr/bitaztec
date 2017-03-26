class Account < ApplicationRecord

  default_scope { order(created_at: :desc) }

  validates :number, length: { is: 19 }, allow_blank: true
  validates :clabe, length: { is: 18 }, allow_blank: true
  validates :card, length: { maximum: 19, minimum: 13 }, allow_blank: true

  validates :holder, presence: true
  validates :active, presence: true
  validates :bank, presence: true

  validate :must_choose_a_number

  belongs_to :bank

  def must_choose_a_number
    if number.blank? and clabe.blank? and card.blank?
      errors.add(:base, 'Debes llenar una de las tres opciones.')
    end
  end

end
