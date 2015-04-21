require 'rails_helper'

RSpec.describe AdminController do
  describe "#index" do
    context "When not logged in" do
      let(:user) {nil}
      it "should display an insufficient permissions error" do
        allow(@controller).to receive(:current_user).and_return(user)
        expect(flash[:error]).to eq("You do not have sufficient permissions to view this page")
      end
    end
    context "When logged in as a user" do
      let(:user) { FactoryGirl.build(:user) }
      it "should display an insufficient permissions error" do
        allow(@controller).to receive(:current_user).and_return(user)
        expect(flash[:error]).to eq("You do not have sufficient permissions to view this page")
      end
    end
    context "When logged in as an admin" do
      let(:user) { FactoryGirl.build(:admin) }
      it "should display the admin panel" do
        allow(@controller).to receive(:current_user).and_return(user)
        expect(response).to be_success
      end
    end
  end
end
