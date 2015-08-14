require 'rails_helper'

RSpec.describe FormTemplate, :type => :model do
  let(:template) { FactoryGirl.build(:form_template) }

  describe "#visible_property_names" do
    it "should return names of properties which are visible" do
      template = FactoryGirl.build(:form_template, :with_title, :with_desc)
      expect(template.visible_property_names).to contain_exactly("title", "description")
    end

    it "shouldn't return hidden properties" do
      template = FactoryGirl.build(:form_template, :with_title, :with_desc)
      template.properties.first.visible = false
      expect(template.visible_property_names).to contain_exactly("description")
    end
  end

  describe "property_names" do
    it "should return all property names" do
      template = FactoryGirl.build(:form_template, :with_title, :with_desc)
      template.properties.first.visible = false
      expect(template.property_names).to contain_exactly("title", "description")
    end
  end

  describe "#required_property_names" do
    it "should return names of properties which are required" do
      template = FactoryGirl.build(:form_template, :with_required_title, :with_desc)
      expect(template.required_property_names).to contain_exactly("title")
    end
  end

  describe "#property_names=" do
    it "should build hidden properties" do
      template.property_names = ["foo", "bar"]
      expect(template.properties.length).to eq(2)
      expect(template.property_names).to contain_exactly("foo", "bar")
      expect(template.visible_property_names).to eq([])
    end

    it "shouldn't add properties that are already on the object" do
      template.properties.build(:name => "foo", :visible => true)
      template.property_names = ["foo", "bar"]
      expect(template.properties.length).to eq(2)
      expect(template.property_names).to contain_exactly("foo", "bar")
      expect(template.visible_property_names).to contain_exactly("foo")
    end

    it "should update the property map" do
      template.properties.build(:name => "foo", :visible => true)
      expect(template.property_map.keys).to contain_exactly("foo")
      template.property_names = ["foo", "bar"]
      expect(template.property_map.keys).to contain_exactly("foo", "bar")
    end
  end

  describe "before save" do
    it "should remove all hidden properties" do
      template.properties.build(:name => "foo", :visible => true)
      template.property_names = ["foo", "bar"]
      template.save
      expect(template.property_names).to contain_exactly("foo")
    end
  end
end
