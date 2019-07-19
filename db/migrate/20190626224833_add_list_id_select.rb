class AddListIdSelect < ActiveRecord::Migration[5.2]
  def change
    add_column :selections,:list_id,:integer
    add_column :purchases,:list_id,:integer
  end
end
