FactoryGirl.define do
  factory :ip_based_group do
    sequence(:title) {|x| "ipgroup_#{x}" }
    transient do
      role_name "iprole"
    end

    after(:build) do |obj, evaluator|
      obj.role = build(:role, :name => evaluator.role_name)
    end
  end
end
