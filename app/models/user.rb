class User < ApplicationRecord
  
  default_scope { order(created_at: :desc) }
  
  has_many :messages

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders

  include Gravtastic
  gravtastic

  # return number of active orders (pending/waiting)
  def active_orders_count
    count = 0
    self.orders.where(completed: false).each do |order|
      if !order.expired or order.submitted
        count += 1
      end
    end
    return count
  end

  # return number of transactions completed
  def transactions_count
    self.orders.where(completed: true).count
  end

end
