class AddRemovedToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :removed, :boolean, default: false
  end
end
