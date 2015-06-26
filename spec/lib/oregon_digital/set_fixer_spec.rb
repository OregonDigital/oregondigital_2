require 'rails_helper'

RSpec.describe OregonDigital::SetFixer do
  subject { described_class.new(solr_service, base, rdf_uri) }

  let(:solr_service) { ActiveFedora::SolrService }
  let(:base) { ActiveFedora::Base }
  let(:rdf_uri) { RDF::URI }

  describe "#fix_set", :slow => true do
    context "with nothing in the repository" do
      it "should not do anything" do
        allow(GenericAsset).to receive(:find)

        subject.fix_set

        expect(GenericAsset).not_to have_received(:find)
      end
    end
    context "with multiple broken assets" do
      it "should fix them all" do
        set = GenericSet.create("test")
        asset = create_asset(set: RDF::URI("http://oregondigital.org/resource/oregondigital:test"))
        asset_2 = create_asset(set: RDF::URI("http://oregondigital.org/resource/oregondigital:test"))
        
        subject.fix_set

        expect(asset.reload.set.first).to eq set
        expect(asset_2.reload.set.first).to eq set
      end
    end
    context "with an object in the repository that has a good set" do
      it "should do nothing" do
        set = GenericSet.create("test")
        create_asset(set: set)
        allow(GenericAsset).to receive(:find)

        subject.fix_set

        expect(GenericAsset).not_to have_received(:find)
      end
    end
  end

  def create_asset(set:)
    GenericAsset.create do |g|
      g.set = Array.wrap(set)
    end
  end
end
