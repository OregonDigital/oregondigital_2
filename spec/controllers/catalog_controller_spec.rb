require 'rails_helper'

RSpec.describe CatalogController do
  describe "#show" do
    context "when given an image" do
      render_views
      it "should render the image show view" do
        i = Image.create(:read_groups => ["public"])

        get 'show', :id => i.id

        expect(response).to render_template "catalog/_show_image"
      end
    end
    describe "permissions" do
      context "when the user has no permission" do
        it "should redirect" do
          i = Image.create

          get 'show', :id => i.id

          expect(response).to be_redirect
        end
      end
    end
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
        expect(graph.statements.to_a.length).to eq 3
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

  describe "#index" do
    context "when there are non-public items" do
      it "should not display them" do
        create_asset(id: 1, public: false)

        get :index

        expect(assigns(:document_list).length).to eq 0
      end
    end
    def create_asset(id:, public:)
      g = GenericAsset.new
      g = ReviewingAsset.new(Reviewable.new(g))
      g.public = public
      solr.add g.to_solr.merge(:id => id)
      solr.commit
      g
    end

    def solr
      ActiveFedora.solr.conn
    end
  end
end
