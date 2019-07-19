class CreateHorses < ActiveRecord::Migration[5.2]
  def change
    create_table :horses do |t|
      t.string :race_name
      t.integer :horce_number
      t.integer :gate_number
      t.string :horse_name
      t.string :sex
      t.integer :year
      t.string :rider

      t.timestamps
    end
  end
end
