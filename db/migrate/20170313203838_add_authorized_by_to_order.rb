class AddAuthorizedByToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :authorized_by, :integer
  end
end
