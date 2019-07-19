class AddYear < ActiveRecord::Migration[5.2]
  def change
    add_column :lists,:year,:integer
  end
end
