class CreateSelections < ActiveRecord::Migration[5.2]
  def change
    create_table :selections do |t|
      t.integer :user_id
      t.integer :prize_number
      t.integer :win
      t.integer :quinella
      t.integer :trio
      t.integer :betting_ticket

      t.timestamps
    end
  end
end
