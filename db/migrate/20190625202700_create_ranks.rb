class CreateRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :ranks do |t|
      t.integer :list_id
      t.integer :win
      t.integer :second
      t.integer :third
      t.integer :gate1
      t.integer :gate2

      t.timestamps
    end
  end
end
