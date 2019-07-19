class CreateMoney < ActiveRecord::Migration[5.2]
  def change
    create_table :money do |t|
      t.integer :user_id
      t.integer :prize_number
      t.integer :unused
      t.integer :used

      t.timestamps
    end
  end
end
