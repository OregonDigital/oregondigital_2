FactoryGirl.define do
  factory :role do
    sequence(:id) {|n| n}
    name 'user'

    trait :admin do
      name "admin"
    end
  end
end
