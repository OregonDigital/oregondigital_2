require 'rails_helper'

RSpec.describe Admin::FacetsController do
  let(:user) { FactoryGirl.create(:user, :admin) }
  before do
    sign_in user
  end
  describe "#index" do
    it "should find the possible solr fields" do
      solr_fields = instance_double(SolrFieldSummary)
      allow(SolrFieldSummary).to receive(:where).with(:field => "*").and_return(solr_fields)
      iterator = instance_double(FacetableSolrFieldIterator)
      allow(FacetableSolrFieldIterator).to receive(:new).with(solr_fields).and_return(iterator)

      get :index

      expect(assigns(:solr_fields)).to eq iterator
    end
  end
end
