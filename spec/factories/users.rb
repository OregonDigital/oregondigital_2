FactoryGirl.define do
  factory :user do
    sequence(:email) {|x| "#{x}test@user.org" }
    password "12345678"
  end

  factory :admin, :class => User do
    id 1
    email "admin@example.org"
    password "admin123"
  end
end
