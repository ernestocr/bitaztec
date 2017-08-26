class CreateJoinTablePaymentMethodCard < ActiveRecord::Migration[5.0]
  def change
    create_join_table :payment_methods, :cards do |t|
      # t.index [:payment_method_id, :card_id]
      # t.index [:card_id, :payment_method_id]
    end
  end
end
