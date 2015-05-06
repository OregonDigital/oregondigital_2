require 'rails_helper'

RSpec.describe Hydra::RoleManagement::RolesController do
  routes { Hydra::RoleManagement::Engine.routes }
  describe "#index" do
    let(:user) {nil}
    before do
      sign_in(user) if user
      get :index
    end
    context "When not logged in" do
      before do
        @routes = ActionDispatch::Routing::RouteSet.new.tap do |r|
          r.draw {get 'root' => 'catalog#index' }
        end
      end
      it "should display an insufficient permissions error" do
        expect(flash[:error]).to eq("You do not have sufficient permissions to view this page")
      end
      it "should redirect" do
        expect(response).to redirect_to root_path
      end
    end
    context "When logged in as a user" do
      before do
        @routes = ActionDispatch::Routing::RouteSet.new.tap do |r|
          r.draw {get 'root' => 'catalog#index' }
        end
      end
      let(:user) { FactoryGirl.create(:user) }
      it "should display an insufficient permissions error" do
        expect(flash[:error]).to eq("You do not have sufficient permissions to view this page")
      end
      it "should redirect" do
        expect(response).to redirect_to root_path
      end
    end
    context "When logged in as an admin" do
      let(:user) { FactoryGirl.create(:user, :admin) }
      it "should display the admin panel" do
        expect(response).to be_success
      end
    end
  end

end
