require 'spec_helper'

describe Item do
 it {should have_many :items_orders_relations}
 it {should have_many(:orders).through(:items_orders_relations)}
 it { should validate_presence_of :name}
 it { should validate_presence_of :price}

 it "price should accomodate 2 decimals" do
   item=Factory.create(:item, price: 23.444444)
   item.price.should == 23.44
 end

 it "should retrieve ranked list of most popular item" do
   user = FactoryGirl.create(:user)
   items=Array.new
   3.times do |n|
     items<<FactoryGirl.create(:item, name: "Name #{n}")
   end
   10.times do |n|
     order = Order.new(user_id: user.id)
     ItemsOrdersRelation.create!(
         :order => order,
         :item => items[1],
         :count => 1)
     order.save
   end

   5.times do |n|
     order = Order.new(user_id: user.id)
     ItemsOrdersRelation.create!(
         :order => order,
         :item => items[1],
         :count => 4)
     order.save
   end

   3.times do |n|
     order = Order.new(user_id: user.id)
     ItemsOrdersRelation.create!(
         :order => order,
         :item => items[1],
         :count => 1)
     order.save

     most_popular = Item.ranked_list
     most_popular[0].should == items[2]
     most_popular[1].should == items[1]
     most_popular[2].should == items[0]

   end

 end
end
