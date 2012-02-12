class Item < ActiveRecord::Base

  has_many :items_orders_relations
  has_many :orders, through: :items_orders_relations
  validates :name, presence: :true
  validates :price, presence: :true


  before_save do
    factor = 10.0**2
    self.price = (self.price*factor).round / factor
  end

  def self.ranked_list
    count_ordered_item = Array.new
    all_items = Item.all
     all_items.each do |item|
       item_count = 0
       ordered_items = ItemsOrdersRelation.where("item_id", item.id)
       ordered_items.each do |ordered_item|
         item_count += ordered_item.count
       end
       count_ordered_item << {item: item, count: item_count}
     end
    sorted_items = count_ordered_item.sort_by{|item| item[:count]}.reverse.map{|item| item[:item]}
  end



end
