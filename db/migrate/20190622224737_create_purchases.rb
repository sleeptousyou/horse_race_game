class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :user_id
      t.integer :prize_number
      t.integer :race_id
      t.integer :price
      t.integer :get
      t.integer :betting_ticket

      t.timestamps
    end
  end
end
