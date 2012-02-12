class CreateItemsOrdersRelations < ActiveRecord::Migration
  def change
    create_table :items_orders_relations do |t|
      t.integer :order_id
      t.integer :user_id
      t.integer :count

      t.timestamps
    end
  end
end
