class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.date :date_of_birth
      t.string :password_digest
      t.float :remaining_balance

      t.timestamps
    end
  end
end
