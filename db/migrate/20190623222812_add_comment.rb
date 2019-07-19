class AddComment < ActiveRecord::Migration[5.2]
  def change
    add_column :lists,:prediction,:text
  end
end
