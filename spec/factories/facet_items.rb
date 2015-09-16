FactoryGirl.define do
  sequence(:value) { |n| "MyString#{n}" }
  factory :facet_item do
    value
    visible true
  end

end
