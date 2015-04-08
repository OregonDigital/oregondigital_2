require 'rails_helper'

RSpec.describe CatalogController do
  describe "#show" do
    describe "nt" do
      it "should return ntriples" do
        title = ["yo"]
        type = RDF::URI("http://example.org/example")
        asset = GenericAsset.new(:id => "bla", :title => title, :read_groups => ["public"])
        asset.resource << [asset.resource.rdf_subject, RDF.type, type]
        asset.save

        get 'show', :id => "bla", :format => :nt
        graph = asset.resource.class.new("http://oregondigital.org/resource/bla") << RDF::Reader.for(:ntriples).new(response.body)
        
        expect(graph.title).to eq title
        expect(graph.type).to eq [type]
      end
    end
  end

  describe "#blacklight_config" do
    let(:blacklight_config) { double("Blacklight Configuration") }
    let(:config) { double("config") }
    before do
      allow(BlacklightConfig).to receive(:new).with(GenericAsset, CatalogController.blacklight_config).and_return(blacklight_config)
      allow(blacklight_config).to receive(:configuration).and_return(config)
    end
    it "should call from BlacklightConfig" do
      expect(controller.blacklight_config).to eq config
    end
  end
end
