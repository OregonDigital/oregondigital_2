require 'rails_helper'

RSpec.describe ReviewerController do
  context "when an admin" do
    before do
      sign_in FactoryGirl.create(:user, :admin)
    end
    describe "#index" do
      describe "rendering" do
        render_views
        it "should render search results" do
          get :index

          expect(response).to render_template "catalog/_search_results"
        end
      end

      describe "results" do
        context "when there are reviewed/public items" do
          it "should not show them" do
            create_asset(id: 1, reviewed: true, public: true)
            get :index

            expect(assigns(:document_list).length).to eq 0
          end
        end
        context "when there are unreviewed/non-public items" do
          it "should show them" do
            create_asset(id: 1, reviewed: false, public: false)
            get :index

            expect(assigns(:document_list).length).to eq 1
          end
        end
        context "when there are unreviewed/public items" do
          it "should show them" do
            create_asset(id: 1, reviewed: false, public: true)
            get :index

            expect(assigns(:document_list).length).to eq 1
          end
        end
      end
      it "should be able to get facets" do
        FacetField.create(:key => "format")
        xhr :get, :facet, :id => 'format_ssim'

        expect(response).to be_successful
      end
    end
    describe "#blacklight_config" do
      it "should be set to reviewing" do
        expect_any_instance_of(BlacklightConfig).to receive(:reviewing=).with(true).and_call_original
        get :index
      end
    end
    describe "#review" do
      it "should mark item as reviewed" do
        item = create_asset(id: 1, reviewed: false, public: false)
        item.save
        patch :review, id: item.id
        expect(response).to be_redirect
        expect(item.reload.workflow_metadata.reviewed).to eq true
      end
    end
  end
  context "when not an admin" do
    it "should not be allowed" do
      get :index

      expect(response).to be_redirect
      expect(flash["alert"]).to eq "You do not have sufficient access privileges to access this."
    end
  end

  def create_asset(id:, reviewed:, public:)
    g = GenericAsset.new
    g = ReviewingAsset.new(Reviewable.new(g))
    g.reviewed = reviewed
    g.public = public
    solr.add g.to_solr.merge(:id => id)
    solr.commit
    g
  end

  def solr
    ActiveFedora.solr.conn
  end

end
