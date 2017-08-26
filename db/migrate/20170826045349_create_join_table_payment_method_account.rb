class CreateJoinTablePaymentMethodAccount < ActiveRecord::Migration[5.0]
  def change
    create_join_table :payment_methods, :accounts do |t|
      t.index [:payment_method_id, :account_id], name: 'index_payment_methods_accounts'
      # t.index [:account_id, :payment_method_id]
    end
  end
end
