class CreatePaymentMethods < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.string :method
      t.string :account
      t.text :details
      t.integer :time_to_expire, default: 3

      t.timestamps
    end
  end
end
