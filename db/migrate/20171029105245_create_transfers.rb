class CreateTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :transfers do |t|

      t.integer :from_user_id
      t.integer :to_user_id
      t.integer :promotion_id, default: 0
      t.decimal :value, :precision => 10, :scale => 2

      t.timestamps
    end

    add_index :transfers, :from_user_id
    add_index :transfers, :to_user_id
    add_index :transfers, :promotion_id

  end
end
