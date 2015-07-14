require 'rails_helper'

RSpec.describe LDPathEnhancement do
  subject { described_class.new(raw_property, ldpath) }
  let(:raw_property) { SolrProperty.new("lcsubject_ssim", value) }
  let(:value) { "http://localhost:40/1" }
  let(:ldpath) { LDPathConfiguration.new(:name => "ldpath", :path => path)}
  let(:path) { "<#{RDF::SKOS.exactMatch}> / <#{RDF::SKOS.prefLabel}>" }
  describe "#properties" do
    context "when there's no path results" do
      it "should return an empty array property" do
        expect(subject.properties.first.values).to eq []
      end
    end
    context "when there's a matching property" do
      it "should return it" do
        deep_node = build_resource(uri: "http://localhost:40/2", label: "Deep Label").tap(&:persist!)
        build_resource(uri: value, label: "Test").tap do |r|
          r << [r.rdf_subject, RDF::SKOS.exactMatch, deep_node.rdf_subject]
        end.persist!

        property = subject.properties.first
        expect(property.values).to eq ["Deep Label"]
        expect(property.key).to eq "lcsubject_ldpath"
        expect(property.solr_identifier).to eq "ssim"
      end
    end
    context "when there's no label" do
      it "should return an empty array property" do
        expect(subject.properties.first.values).to eq []
      end
    end
  end
end
