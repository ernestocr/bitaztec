class ChangeOrderAmountToDecimal < ActiveRecord::Migration[5.0]

  def up
    change_column :orders, :amount, :decimal
  end

  def down
    change_column :orders, :amount, :integer
  end

end
