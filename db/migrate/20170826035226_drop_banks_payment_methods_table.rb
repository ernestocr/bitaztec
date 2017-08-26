class DropBanksPaymentMethodsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :banks_payment_methods
  end
end
