FactoryGirl.define do
  factory :user do
    
  end

  factory :admin, :class => User do
    id 1
    email "admin@example.org"
    password "admin123"
    password_confirmation "admin123"
  end
end
