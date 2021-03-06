require 'bitcoin'

class Order < ApplicationRecord

  default_scope { order(created_at: :desc) }
  
  has_many :messages, dependent: :delete_all

  belongs_to :payment_method
  belongs_to :user

  validates :user, presence: true
  validates :payment_method_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true

  validate :valid_btc_address

  mount_uploaders :attachments, AttachmentUploader

  before_create :add_expires_at
  before_create :round_amount

  # order status, depending on a variety of situations
  def status
    if completed
      'Completado'
    elsif submitted
      'En proceso de revisión'
    elsif removed
      'Cancelado'
    elsif expired
      'Expirado'
    else
      'Esperando el pago y/o evidencia'
    end
  end

  # rounded price
  def total
    (amount * price).round(2)
  end

  # true/false if expired
  def expired
    return DateTime.now.utc > expires_at.utc
  end

  # is it canceled?
  def canceled
    removed
  end

  # Messages

  # unread by user?
  def new_message_for_user?
    messages.each do |msg|
      if !msg.user_read
        return true
      end
    end
    return false
  end

  # unread by admin?
  def new_message_for_admin?
    messages.each do |msg|
      if !msg.admin_read
        return true
      end
    end
    return false
  end

  # authorized_by
  def completed_by
    if authorized_by != nil
      User.find(authorized_by)
    else
      'Not completed'
    end
  end

  # Validator
  def valid_btc_address
    if address and !Bitcoin.valid_address? address
      errors.add(:address, 'No es un wallet valido.')
    end
  end

  private

    def add_expires_at
      self.expires_in = self.payment_method.expires
      self.expires_at = DateTime.now.utc + self.expires_in.hours
    end

    def round_amount
      self.amount = self.amount.round(8)
    end

end
