class AddBracket < ActiveRecord::Migration[5.2]
  def change
    add_column :dividends,:bracket_quinella,:integer
    remove_column :dividends,:blacket_quinella,:integer
  end
end
