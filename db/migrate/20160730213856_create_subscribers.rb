class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      ## Attributable
      t.string :email, null: false

      ## Timestamps
      t.timestamps null: false
    end

    add_index :subscribers, :email
  end
end
