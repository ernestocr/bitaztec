require 'Bitcoin'

class Order < ApplicationRecord

  default_scope { order(created_at: :desc) } 
  has_many :messages

  belongs_to :payment_method
  belongs_to :user

  validates :user, presence: true
  validates :payment_method_id, presence: true
  validates :amount, presence: true
  validates :price, presence: true
  validates :address, presence: true
  
  validate :valid_btc_address

  mount_uploaders :attachments, AttachmentUploader

  # order status, depending on a variety of situations
  def status
    if completed
      'Completado'
    elsif canceled
      'Cancelada'
    elsif submitted
      'Pendiente'
    elsif expired
      'Expirado'
    else
      'Esperando el pago y/o evidencia'
    end
  end

  # true/false if expired
  def expired
    expires = created_at + expires_in.hours
    return DateTime.now.utc > expires.utc
  end

  # what time does it expire at?
  def expires_at
    created_at + expires_in.hours
  end

  # is it canceled?
  def canceled
    false
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

  # EXTRAS
  
  def created_at_formatted
    created_at.strftime('%d/%m/%Y at %I:%M %p')
  end

  def expires_at_formatted
    expires_at.strftime('%d/%m/%Y at %I:%M %p')
  end

  # Validator
  def valid_btc_address
    if !Bitcoin.valid_address? address
      errors.add(:address, 'No es un wallet valido.')
    end
  end

end
