namespace :orders do

  desc "Check and notify user of expired orders"
  task notify_expiration: :environment do
    count = 0
    Order.where(submitted: false).each do |order|
      if order.expired
        count += 1

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
    if count == 0
      puts "Did not find any expired orders"
    end
  end

end
