class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.string :name
      t.string :location
      t.text :description
      t.date :date
      t.string :category
      t.boolean :is_expense
      t.references :payment_method, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
