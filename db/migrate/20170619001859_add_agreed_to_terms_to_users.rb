class AddAgreedToTermsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :agreed_to_terms, :boolean, default: false
  end
end
