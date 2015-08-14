FactoryGirl.define do
  factory :form_template do
    sequence(:title) {|x| "template_#{x}" }

    trait :with_title do
      after(:build) do |obj|
        obj.properties << build(:form_template_property, :name => "title")
      end
    end

    trait :with_required_title do
      after(:build) do |obj|
        obj.properties << build(:form_template_property, :name => "title", :required => true)
      end
    end

    trait :with_desc do
      after(:build) do |obj|
        obj.properties << build(:form_template_property, :name => "description")
      end
    end
  end
end
