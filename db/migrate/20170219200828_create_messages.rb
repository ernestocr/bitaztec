class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :user_read, default: false
      t.boolean :admin_read, default: false

      t.timestamps
    end
  end
end
