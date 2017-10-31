class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.string :label
      t.string :name
      t.decimal :value, :precision => 10, :scale => 2
      t.integer :promotion_type
      t.boolean :is_active
      t.timestamps
    end
  end
end
