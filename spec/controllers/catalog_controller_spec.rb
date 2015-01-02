require 'rails_helper'

RSpec.describe CatalogController do
  describe "#show" do
    describe "nt" do
      before do
        g = GenericAsset.new(:id => "bla", :title => ["yo"], :read_groups => ["public"])
        g.resource << [g.resource.rdf_subject, RDF.type, RDF::URI("http://example.org/example")]
        g.save
        get 'show', :id => "bla", :format => :nt
      end
      it "should return ntriples" do
        lines = response.body.split("\n")
        expect(lines.length).to eq 2
        expect(lines.last).to eq '<http://oregondigital.org/resource/bla> <http://purl.org/dc/terms/title> "yo" .'
      end
    end
  end
end
