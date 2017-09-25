class CreatePaymentMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_methods do |t|
      t.string :payment_type
      t.string :last_four_digits
      t.string :bank
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
