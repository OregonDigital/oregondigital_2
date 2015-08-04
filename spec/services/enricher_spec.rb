require 'rails_helper'

RSpec.describe Enricher do
  subject { described_class.new(id) }
  let(:id) { asset.id }
  let(:asset) do
    a = GenericAsset.new do |g|
      g.lcsubject = [uri]
    end
    allow(a).to receive(:id).and_return("yo")
    solr.add a.to_solr.merge(:id => a.id)
    solr.commit
    a
  end
  let(:uri) { resource.rdf_subject }
  let(:resource) do
    r = TriplePoweredResource.new("http://localhost:40/1")
    r.preflabel = "Test"
    r.persist!
    r
  end
  let(:solr) { ActiveFedora.solr.conn }

  describe "#enrich!" do
    it "should enrich the solr document" do
      subject.enrich!

      expect(ActiveFedora::SolrService.query("id:#{id}").first["lcsubject_preferred_label_ssim"]).to eq ["Test"]
    end
  end
end
