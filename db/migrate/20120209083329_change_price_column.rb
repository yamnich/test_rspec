class ChangePriceColumn < ActiveRecord::Migration
  def up
    change_column :items, :price, :decimal, precision: 6, scale: 2
  end

  def down
    change_column :items, :price, :float
  end
end
