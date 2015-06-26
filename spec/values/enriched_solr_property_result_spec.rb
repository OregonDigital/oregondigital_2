require 'rails_helper'

RSpec.describe EnrichedSolrPropertyResult do
  subject { described_class.new(key, document) }
  let(:key) { :title_ssim }
  describe "#values" do
    let(:result) { subject.values }
    context "when given URIs in document" do
      let(:document) do
        {
          :title_ssim => ["http://test.test.com"]
        }
      end
      it "should not return them" do
        expect(result).to eq []
      end
    end
    context "when given URIs and strings" do
      let(:document) do
        {
          :title_ssim => ["Test", "http://test.test.com", "Test2"]
        }
      end
      it "should only return the strings" do
        expect(result).to eq ["Test", "Test2"]
      end
    end
    context "when there are preferred labels" do
      let(:document) do
        {
          :title_ssim => ["Test", "http://test.test.com"],
          SolrProperty.new(:title_ssim,nil).derivative_properties[:preferred_label].property_key => ["Enriched"]
        }
      end
      it "should return them" do
        expect(result).to eq ["Enriched", "Test"]
      end
    end
    context "when there are other sub-keys" do
      let(:document) do
        {
          :title_ssim => ["Test"],
          :title_alt_label_ssim => ["Alternative"]
        }
      end
      it "should not return them" do
        expect(result).to eq ["Test"]
      end
    end
  end
end
