class AddWin < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases,:win,:integer
    add_column :purchases,:quinella,:integer
    add_column :purchases,:trio,:integer
  end
end
