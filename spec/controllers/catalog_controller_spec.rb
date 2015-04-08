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
end
