class AddDeprecatedToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :deprecated, :boolean, default: false
  end
end
