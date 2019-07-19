class AddPrizeNumber < ActiveRecord::Migration[5.2]
  def change
    add_column :horses,:prize_number,:integer
  end
end
