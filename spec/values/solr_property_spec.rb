require 'rails_helper'

RSpec.describe SolrProperty do
  subject { described_class.new(key, values) }
  let(:key) { "lc_subject_ssim" }
  let(:values) { ["test"] }

  describe "#key" do
    it "should return without the identifier" do
      expect(subject.key).to eq "lc_subject"
    end
  end

  describe "#derivative_properties" do
    let(:result) { subject.derivative_properties }
    it "should return preferred label" do
      expect(result[:preferred_label].key).to eq "lc_subject__preferred_label"
    end
    it "should return alternative label" do
      expect(result[:alternative_label].key).to eq "lc_subject__alternative_label"
      expect(result[:alternative_label].base).to eq "lc_subject"
    end
  end

  describe "#values" do
    it "should return the values" do
      expect(subject.values).to eq values
    end
  end

  describe "#solr_identifier" do
    it "should return the solr identifier" do
      expect(subject.solr_identifier).to eq "ssim"
    end
  end
  
end
