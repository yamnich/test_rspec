class Address < ActiveRecord::Base
  belongs_to :user
  validates :street, :city, :zip, :presence => true

  before_create do
    self.country ||= 'Ukraine'
  end

end
