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

      get :index

      expect(assigns(:facets)).to eq facade
    end
  end

  describe "#create" do
    it "should be able to make a facet" do
      post :create, :facet_field => {:key => "test"}

      expect(FacetField.first.key).to eq "test"
      expect(flash[:success]).to eq I18n.t("admin.facets.field_created")
    end
  end

  describe "#update" do
    it "should be able to update a facet" do
      facet = FacetField.create(:key => "test", :label => "yo")

      put :update, :id => facet.id, :facet_field => {:label => "test"}

      expect(facet.reload.label).to eq "test"
    end
  end

  describe "#destroy" do
    context "when the field doesn't exist" do
      it "should redirect and show a flash" do
        delete :destroy, :id => "1"

        expect(response).to redirect_to admin_facets_path
        expect(flash[:alert]).to eq I18n.t("admin.facets.destroy.fail")
      end
    end
    context "when the field exists" do
      it "should delete it" do
        field = FacetField.create(:key => "test")

        delete :destroy, :id => field.id.to_s

        expect(response).to redirect_to admin_facets_path
        expect(flash[:success]).to eq I18n.t("admin.facets.destroy.success")
        expect(FacetField.where(:id => field.id).count).to eq 0
      end
    end
  end

  describe "#remove_item" do
    it "should remove item" do
      FacetField.create(:key => "hello", :label => "world")
      item = FacetItem.create(:value => "my set")
      patch :remove_item, id: item.id.to_s
      expect(response).to redirect_to admin_facets_path
      expect(flash[:success]).to eq I18n.t("admin.facets.remove_item.success")
      expect(FacetItem.where(:id => item.id).first.visible).to eq false
    end
  end

  describe "#add_item" do
    it "should add item" do
      FacetField.create(:key => "hello", :label => "world")
      item = FacetItem.create(:value => "my set")
      patch :remove_item, id: item.id.to_s
      expect(FacetItem.where(:id => item.id).first.visible).to eq false
      patch :add_item, id: item.id.to_s
      expect(response).to redirect_to admin_facets_path
      expect(flash[:success]).to eq I18n.t("admin.facets.field_item_added")
      expect(FacetItem.where(:id => item.id).first.visible).to eq true
    end

  end

end
