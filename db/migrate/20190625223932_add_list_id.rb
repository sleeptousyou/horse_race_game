class AddListId < ActiveRecord::Migration[5.2]
  def change
    add_column :horses,:list_id,:integer
  end
end
