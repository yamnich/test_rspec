class User < ActiveRecord::Base
  validates :first_name, :last_name, :presence => true
  has_many :posts
  has_many :addresses
  has_many :orders

  def full_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  def bought_items
    user_items = Array.new
    orders = Order.where("user_id = ?", self.id)
    orders.each do |order|
      order.items.each do |item|
        user_items << item
      end
    end
    user_items
  end

  def self.active_customers
    most_active_customers = Array.new
  d
    all_customers = User.all
    all_customers.each do |customer|
      orders = customer.orders.where("created_at > ?", Time.now - 90*24*60*60)
      count = orders.count
      if count > 2
        most_active_customers<<customer
      elsif count == 1
        if orders.first.items.count > 2
          most_active_customers<<customer
        end
      else
        most_active_customers
      end
    end
    most_active_customers
  end



end
