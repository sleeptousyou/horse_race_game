class AddRecoveryToYear < ActiveRecord::Migration[5.2]
  def change
    add_column :recoveries,:year,:integer
  end
end
