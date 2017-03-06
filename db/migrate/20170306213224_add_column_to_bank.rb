class AddColumnToBank < ActiveRecord::Migration[5.0]
  def change
    add_column :banks, :image, :string
  end
end
