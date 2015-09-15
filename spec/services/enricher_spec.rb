require 'rails_helper'

RSpec.describe Enricher do
  subject { described_class.new(id) }
  let(:id) { asset.id }
  let(:asset) do
    a = GenericAsset.new do |g|
      g.lcsubject = [uri]
      g.creator = [uri2]
      g.author = [uri3]
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
  let(:uri2) { resource2.rdf_subject }
  let(:resource2) do
    r2 = TriplePoweredResource.new("http://localhost:40/2")
    r2.preflabel = "mycreator"
    r2.persist!
    r2
  end
  let(:uri3) { resource3.rdf_subject }
  let(:resource3) do
    r3 = TriplePoweredResource.new("http://localhost:40/3")
    r3.preflabel = "myauthor"
    r3.persist!
    r3
  end

  let(:solr) { ActiveFedora.solr.conn }

  describe "#enrich!" do
    it "should enrich the solr document" do
      subject.enrich!

      expect(ActiveFedora::SolrService.query("id:#{id}").first["lcsubject_preferred_label_ssim"]).to eq ["Test"]
      expect(ActiveFedora::SolrService.query("id:#{id}").first["ubercreator_preferred_label_ssim"]).to eq ["mycreator","myauthor"]
      expect(ActiveFedora::SolrService.query("id:#{id}").first["ubercreator_ssim"]).to eq ["http://localhost:40/2","http://localhost:40/3"]
    end
  end
end
