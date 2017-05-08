class Notification < ApplicationRecord

  belongs_to :recipient, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }
  default_scope { order(created_at: :desc) }

  def message
    if self.action == 'completed'
      "Tu pedido ha sido completado exitosamente!"
    elsif self.action == 'expired'
      "Tu pedido ha expirado. Tendrás que hacer uno nuevo."
    else
      "Missing notification message."
    end
  end
  
  def link
    if self.action == 'expired'
      "#"
    else
      "/orders/#{self.notifiable_id}"
    end
  end

end
