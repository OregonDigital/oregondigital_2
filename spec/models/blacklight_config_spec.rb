require 'rails_helper'

RSpec.describe BlacklightConfig do
  subject { BlacklightConfig.new(resource) }
  let(:resource) { GenericAsset }

  describe "#default_configuration" do
    it "should not error" do
      expect{subject.default_configuration}.not_to raise_error
    end
    it "should be the CatalogController's config" do
      expect(subject.default_configuration).to eq CatalogController.blacklight_config
    end
  end

  describe "#configuration" do
    it "should be a Blacklight::Configuration" do
      expect(subject.configuration).to be_instance_of Blacklight::Configuration
    end
    it "should have a show field config for each field" do
      keys = subject.configuration.show_fields.values.map(&:key)
      labels = subject.configuration.show_fields.values.map(&:label)
      expect(keys).to include "title_ssm"
      expect(labels).to include "Title"
      expect(keys).to include "alternative_ssm"
      expect(labels).to include "Alternative"
      expect(keys).to include *GenericAsset.properties.keys.map{|x| "#{x}_ssm"}
    end
  end

end
