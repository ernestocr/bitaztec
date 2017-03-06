class AddImageToPaymentMethods < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_methods, :image, :string
  end
end
