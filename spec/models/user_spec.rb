require "spec_helper"

describe User do

  it { should have_many :addresses }
  it {should have_many :orders}

  before(:each) do
    @user = FactoryGirl.build(:user, valid_user_data)
  end

  it "should have first name" do
    @user.first_name = nil
    @user.should_not be_valid
  end

  it "should have last name" do
    @user.last_name = nil
    @user.should_not be_valid
  end

  it "should be valid with first and last name" do
    @user.should be_valid
  end

  it "should have full name" do
    @user.full_name.should == "John Dima Doe"
  end

  it "should create user with valid data" do
    lambda {
      User.create(valid_user_data)
    }.should change { User.count }
  end

  def valid_user_data
    {:first_name => 'John', :last_name => 'Doe', :middle_name => 'Dima'}
  end



  it "should return all items bought person" do
    first_user = FactoryGirl.create(:user)
    second_user = FactoryGirl.create(:user)

    first_user_items = Array.new
    second_user_items = Array.new

    3.times do |n|
      first_user_items << FactoryGirl.create(:item, name: "Name 1#{n}")
      order = Order.new(user_id: first_user.id)
      order.items << first_user_items[n]
      order.save
    end

    4.times do |n|
      second_user_items << FactoryGirl.create(:item, name: "Name 2#{n}")
      order = Order.new(user_id: second_user.id)
      order.items << second_user_items[n]
      order.save
    end


    first_user.bought_items.should == first_user_items
    second_user.bought_items.should == second_user_items
  end
  it "should return all items bought person" do
    first_user = FactoryGirl.create(:user)
    second_user = FactoryGirl.create(:user)

    first_user_items = Array.new
    second_user_items = Array.new

    3.times do |n|
      first_user_items << FactoryGirl.create(:item, name: "Name 1#{n}")
      order = Order.new(user_id: first_user.id)
      order.items << first_user_items[n]
      order.save
    end

    4.times do |n|
      second_user_items << FactoryGirl.create(:item, name: "Name 2#{n}")
      order = Order.new(user_id: second_user.id)
      order.items << second_user_items[n]
      order.save
    end


    first_user.bought_items.should == first_user_items
    second_user.bought_items.should == second_user_items
  end

  it "should retrieve list of customers who ordered 2 or more items at last 90 days " do
    item = FactoryGirl.create(:item)
    users = Array.new

    3.times do |n|
      users << FactoryGirl.create(:user, first_name: "user #{n}")
      order = users[n].orders.new
      3.times do
        order.items << item
      end
      order.save
    end

     not_active_users = Array.new
    3.times do |n|
      not_active_users << FactoryGirl.create(:user, first_name: "na_user #{n}")
      order = users[n].orders.new(created_at: Time.now-91*24*60*60)
      order.items << item
      order.save
    end

    User.active_customers.should == users
    User.active_customers.should_not == not_active_users

  end

end