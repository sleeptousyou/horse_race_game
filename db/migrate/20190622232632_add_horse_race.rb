class AddHorseRace < ActiveRecord::Migration[5.2]
  def change
    add_column :horses,:horse_number,:integer
    remove_column :horses,:horce_number,:integer
  end
end
