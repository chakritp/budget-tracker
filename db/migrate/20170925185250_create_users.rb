class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :date_of_birth
      t.string :password_digest
      t.float :remaining_balance, default: 0

      t.timestamps
    end
  end
end
