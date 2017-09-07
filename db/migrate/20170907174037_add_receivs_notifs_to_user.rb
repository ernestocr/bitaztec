class AddReceivsNotifsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :receives_notifs, :boolean, default: true
  end
end
