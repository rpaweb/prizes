class CreateTemporalPrizes < ActiveRecord::Migration
  def change
    create_table :temporal_prizes do |t|
      t.integer :prize_id
      t.string  :prize_name
    end

    add_index :temporal_prizes, [ :prize_id, :prize_name ]
  end
end
