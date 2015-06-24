require 'rails_helper'

RSpec.describe SolrDocument do
  subject { SolrDocument.new(resource.to_solr) }
  let(:resource) do
    GenericAsset.new do |g|
      g.workflow_metadata.medium_path = OregonDigital.derivative_injector.medium_path("test").to_s
      g.workflow_metadata.pyramidal_path = OregonDigital.derivative_injector.pyramidal_path("test").to_s
    end
  end
  describe "#[]" do
    context "when enriched" do
      subject { SolrDocument.new(resource.to_solr.merge(enriched)) }
      let(:enriched) do
        {
          :title_ssim => ["http://test.test.org", "Raw String"],
          :title_preferred_label_ssim => ["Test"],
          :title_alt_label_ssim => ["Alternative"]
        }
      end
      it "should show title labels together with their preferred label" do
        expect(subject[:title_ssim]).to eq ["Test", "Raw String"]
      end
    end
  end
  describe "#derivative_paths" do
    let(:result) { subject.derivative_paths }
    it "should return all the derivative paths" do
      expect(result[:medium_image].relative_path.to_s).to eq "/media/medium-images/t/s/test.jpg"
      expect(result[:pyramidal].relative_path.to_s).to eq "/media/pyramidal/t/s/test.tiff"
    end
    it "should return a null path for non-existent paths" do
      expect(result[:blabla_image].relative_path.to_s).to eq ""
    end
  end
end
