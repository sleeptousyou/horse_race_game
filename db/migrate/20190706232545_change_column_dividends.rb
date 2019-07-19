class ChangeColumnDividends < ActiveRecord::Migration[5.2]
  def change
    remove_column :dividends,:quinella_place,:integer
    remove_column :dividends,:place,:integer
    add_column :dividends,:place1,:integer
    add_column :dividends,:place2,:integer
    add_column :dividends,:place3,:integer
    add_column :dividends,:quinella_place1,:integer
    add_column :dividends,:quinella_place2,:integer
    add_column :dividends,:quinella_place3,:integer
  end
end
