class AddColumnToPaymentMethods < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_methods, :deprecated, :boolean, default: false
  end
end
