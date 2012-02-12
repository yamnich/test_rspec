require 'spec_helper'

describe Address do

  [:street, :city, :zip].each do |f|
    it { should validate_presence_of f}
  end

  it "should have default country Ukraine" do
    address = FactoryGirl.create(:address, :country => nil)
    address.country.should == 'Ukraine'
  end

  it "should return google coordinates" do
    pending
  end

  it "should show best transport" do
    pending
  end

end
