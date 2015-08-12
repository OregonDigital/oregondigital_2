require 'rails_helper'

RSpec.describe FormTemplate, :type => :model do
  describe "#visible_property_names" do
    it "should return names of properties which are visible" do
      template = FactoryGirl.build(:form_template, :with_title, :with_desc)
      template.save
      expect(template.visible_property_names).to contain_exactly("title", "description")
      template.properties.first.visible = false
      template.save
      expect(template.visible_property_names).to contain_exactly("description")
    end
  end
end
