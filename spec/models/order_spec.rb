require "spec_helper"

describe Order do

  it {should belong_to :user}
  it {should have_many :items_orders_relations}
  it {should have_many(:items).through(:items_orders_relations)  }

  it "should require presence at least one item" do
    wrong_order = FactoryGirl.build(:order)
    wrong_order.should_not be_valid

    item = FactoryGirl.build(:item)
    valid_order = FactoryGirl.build(:order)
    valid_order.items << item
    valid_order.should be_valid
  end






end