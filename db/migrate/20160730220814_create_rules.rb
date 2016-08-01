class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      ## Attributable
      t.string  :policy, null: false
      t.integer :specific
      t.integer :multipleof

      ## Timestamps
      t.timestamps null: false
    end
  end
end
