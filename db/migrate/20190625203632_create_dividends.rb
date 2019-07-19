class CreateDividends < ActiveRecord::Migration[5.2]
  def change
    create_table :dividends do |t|
      t.integer :list_id
      t.integer :win
      t.integer :place
      t.integer :blacket_quinella
      t.integer :quinella
      t.integer :quinella_place 
      t.integer :exacta
      t.integer :trio
      t.integer :trifecta

      t.timestamps
    end
  end
end
