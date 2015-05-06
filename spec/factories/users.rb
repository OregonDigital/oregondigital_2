FactoryGirl.define do
  factory :user do
    sequence(:email) {|x| "#{x}test@user.org" }
    password "12345678"
    trait :admin do
      after(:build) do |obj|
        obj.roles << build(:role, :name => "admin")
      end
    end
  end
end
