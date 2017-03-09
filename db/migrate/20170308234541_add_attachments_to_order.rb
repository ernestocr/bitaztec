class AddAttachmentsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :attachments, :string, array: true, default: [] # add attachment column as array
  end
end
