class CreateBallots < ActiveRecord::Migration[5.2]
  def change
    create_table :ballots do |t|
      t.integer :user_id
      t.integer :list_id

      t.timestamps
    end
  end
end
