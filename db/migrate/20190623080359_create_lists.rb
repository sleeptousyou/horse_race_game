class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :race_name
      t.boolean :thisweek

      t.timestamps
    end
  end
end
