class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items_orders_relations
  has_many :items, through: :items_orders_relations


  validate :validate_items_count

  def validate_items_count
    errors.add(:items, "less then 1") if items.length < 1
  end


end
