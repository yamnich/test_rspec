# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    country "England"
    street "Baker str."
    city "London"
    zip "9123"
  end
end
