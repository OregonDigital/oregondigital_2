require 'rails_helper'

RSpec.describe Admin::FacetsController do
  let(:user) { FactoryGirl.create(:user, :admin) }
  before do
    sign_in user
  end
  describe "#index" do
    it "should find the possible solr fields" do
      facade = instance_double(FacetConfigurationFacade)
      allow(FacetConfigurationFacade).to receive(:new).and_return(facade)
      new_facet = instance_double(FacetField)
      allow(FacetField).to receive(:new).and_return(new_facet)

      get :index

      expect(assigns(:facets)).to eq facade
      expect(assigns(:facet)).to eq new_facet
    end
  end

  describe "#create" do
    it "should be able to make a facet" do
      post :create, :facet_field => {:key => "test"}

      expect(FacetField.first.key).to eq "test"
    end
  end
end
