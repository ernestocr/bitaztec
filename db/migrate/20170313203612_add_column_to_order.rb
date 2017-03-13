class AddColumnToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :completed_at, :datetime
  end
end
