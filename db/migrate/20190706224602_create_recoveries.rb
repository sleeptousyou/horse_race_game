class CreateRecoveries < ActiveRecord::Migration[5.2]
  def change
    create_table :recoveries do |t|
      t.integer :list_id
      t.integer :user_id
      t.integer :sum_price
      t.integer :sum_get
      t.integer :hit

      t.timestamps
    end
  end
end
