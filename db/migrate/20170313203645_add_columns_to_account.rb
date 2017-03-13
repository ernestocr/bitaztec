class AddColumnsToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :clabe, :string
    add_column :accounts, :card, :string
  end
end
