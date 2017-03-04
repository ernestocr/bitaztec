class CreateJoinTablePaymentMethodBank < ActiveRecord::Migration[5.0]
  def change
    create_join_table :payment_methods, :banks do |t|
      # t.index [:payment_method_id, :bank_id]
      # t.index [:bank_id, :payment_method_id]
    end
  end
end
