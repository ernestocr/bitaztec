class AddColumnsToPaymentMethods < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_methods, :schedule, :string
    add_column :payment_methods, :instructions, :text
    add_column :payment_methods, :notice, :text
    add_column :payment_methods, :active, :boolean
  
    remove_column :payment_methods, :account, :string
    rename_column :payment_methods, :time_to_expire, :expires
  end
end
