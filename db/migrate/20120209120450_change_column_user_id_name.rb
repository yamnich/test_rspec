class ChangeColumnUserIdName < ActiveRecord::Migration
  def up
    rename_column :items_orders_relations, :user_id, :item_id
  end

  def down
    rename_column :items_orders_relations, :item_id, :user_id
  end
end
