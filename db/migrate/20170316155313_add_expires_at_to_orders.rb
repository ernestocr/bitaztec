class AddExpiresAtToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :expires_at, :datetime
  end
end
