class RenameSomeColumnsInOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :confirmed_account
    remove_column :orders, :confirmed_card
  end
end
