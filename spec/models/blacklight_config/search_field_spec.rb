require 'rails_helper'

RSpec.describe BlacklightConfig::SearchField do
  subject { described_class.new(field, opts) }
  let(:field) { "all_fields" }
  let(:opts) { {} }
  describe "#key" do
    it "should be passed field" do
      expect(subject.key).to eq field
    end
  end

  describe "#label" do
    it "should titleize the field" do
      expect(subject.label).to eq "All Fields"
    end
    context "when passed a label" do
      let(:opts) { {:label => "Test"} }
      it "should be the passed label" do
        expect(subject.label).to eq "Test"
      end
    end
  end

  describe "#solr_parameters" do
    context "when passed a qf" do
      let(:opts) { {:qf => "test_field"}}
      it "should return it" do
        expect(subject.solr_parameters).to eq ({:qf => "test_field"})
      end
    end
    context "by default" do
      it "should set qf" do
        qf = subject.solr_parameters[:qf]
        expect(qf).to include Solrizer.solr_name(field, :stored_searchable)
      end
      it "should add derivative keys" do
        qf = subject.solr_parameters[:qf]
        expect(qf).to include Solrizer.solr_name(field+"_preferred_label", :stored_searchable)
      end
    end
  end
end
