class CreateBettingTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :betting_tickets do |t|
      t.string :kind

      t.timestamps
    end
  end
end
