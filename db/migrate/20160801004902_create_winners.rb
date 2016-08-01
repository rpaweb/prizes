class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      ## Referenceable
      t.references :subscriber, index: true, foreign_key: true
      t.references :prize, index: true, foreign_key: true

      ## Timestamps
      t.timestamps null: false
    end

    add_index :winners, [ :subscriber_id, :prize_id ]
  end
end
