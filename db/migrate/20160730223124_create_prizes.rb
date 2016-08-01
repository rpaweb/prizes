class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      ## Attributable
      t.string  :name, null: false
      t.string  :desc, null: false
      t.string  :photo, null: false
      t.integer :amount, null: false

      ## Referenceable
      t.references :rule, index: true, foreign_key: true

      ## Timestamps
      t.timestamps null: false
    end

    add_index :prizes, [ :name, :rule_id ]
  end
end
