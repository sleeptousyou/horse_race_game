class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.integer :user_id
      t.integer :total_get
      t.float :recovery_rate
      t.float :hit_ratio
      t.integer :most_high_get
      t.integer :year

      t.timestamps
    end
  end
end
