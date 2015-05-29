require 'rails_helper'

RSpec.describe LabelEnhancement do
  subject { described_class.new(property) }
  let(:property) { SolrProperty.new("lcsubject_ssim", value) }
  let(:value) { "http://localhost:40/1" }

  describe "#property" do
    context "when there's a label" do
      it "should return a nice property" do
        build_resource(uri: value, label: "Test")

        property = subject.property
        expect(property.values).to eq ["Test"]
        expect(property.key).to eq "lcsubject_preferred_label"
        expect(property.solr_identifier).to eq "ssim"
      end
    end
    context "when there's no label" do
      it "should return an empty array property" do
        expect(subject.property.values).to eq []
      end
    end
  end
end
