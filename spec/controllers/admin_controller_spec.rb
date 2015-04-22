require 'rails_helper'

RSpec.describe AdminController do
  describe "#index" do
    let(:user) {nil}
    before do
      sign_in(user) if user
      get :index
    end
    context "When not logged in" do
      it "should display an insufficient permissions error" do
        expect(flash[:error]).to eq("You do not have sufficient permissions to view this page")
      end
      it "should redirect" do
        expect(response).to redirect_to root_path
      end
    end
    context "When logged in as a user" do
      let(:user) { FactoryGirl.create(:user) }
      it "should display an insufficient permissions error" do
        expect(flash[:error]).to eq("You do not have sufficient permissions to view this page")
      end
      it "should redirect" do
        expect(response).to redirect_to root_path
      end
    end
    context "When logged in as an admin" do
      let(:user) { FactoryGirl.create(:admin) }
      it "should display the admin panel" do
        expect(response).to be_success
      end
    end
  end
end
