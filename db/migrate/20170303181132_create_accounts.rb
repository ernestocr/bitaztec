class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :number
      t.string :holder
      t.references :bank, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
