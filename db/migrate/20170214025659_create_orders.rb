class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :payment_method, foreign_key: true
      t.integer :amount
      t.integer :price
      t.boolean :submitted, default: false
      t.integer :expires_in, default: 3
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
