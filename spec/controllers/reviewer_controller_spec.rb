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
