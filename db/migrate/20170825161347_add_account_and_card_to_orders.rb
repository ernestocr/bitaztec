class AddAccountAndCardToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :account, foreign_key: true
    add_reference :orders, :card, foreign_key: true
    add_column :orders, :confirmed_account, :string
    add_column :orders, :confirmed_card, :string
  end
end
