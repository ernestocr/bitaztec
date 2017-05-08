namespace :orders do

  desc "Check and notify user of expired orders"
  task notify_expiration: :environment do
    Order.where(submitted: false).each do |order|
      if order.expired
        puts "Order ##{order.id} has expired."
        # notify expiration
        Notification.create(
          recipient: order.user,
          action: 'expired', 
          notifiable: order
        )
        puts "User #{order.user.email} has been notified."
        # delete the order
        order.destroy
        puts "Order ##{order.id} has been destroyed."
      end 
    end
  end

end
