class AddConfirmedAccountAndConfirmedCardtoOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :confirmed_account, references: :accounts
    add_reference :orders, :confirmed_card, references: :cards
  end
end
