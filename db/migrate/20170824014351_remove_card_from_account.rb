class RemoveCardFromAccount < ActiveRecord::Migration[5.0]
  def change
    remove_column :accounts, :card
  end
end
