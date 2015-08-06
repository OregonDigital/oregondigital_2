require 'rails_helper'

RSpec.describe "Updating a record" do
  let(:asset) { Image.new(id) }
  let(:reviewable_asset) { Reviewable.new(asset) }
  let(:id) { "1" }
  let(:user) { FactoryGirl.create(:user, :admin) } 
  let(:reviewed_status) {GenericAsset.find(id).workflow_metadata.reviewed}

  before do
    sign_in_user(user)
  end

  context "when updating an existing record that has been reviewed" do
    before do
      g = review_asset
      visit "/records/#{g.id}/edit"
    end
    context "and wanting it to be re-reviewed" do
      before do
        uncheck("Reviewed")
        click_button "Save"
      end

      it "should set that record to not reviewed again" do
        expect(reviewed_status).to eq false
      end
    end
    context "and not wanting it to be re-reviewed" do
      before do
        click_button "Save"
      end

      it "should keep that record as reviewed" do
        expect(reviewed_status).to eq true
      end
    end
 
  end
  context "when updating an existing record that has not been reviewed" do
    before do
      g = reviewable_asset
      g.save
      visit "/records/#{g.id}/edit"
    end
    context "and wanting it to be re-reviewed" do
      before do
        uncheck("Reviewed")
        click_button "Save"
      end

      it "should set that record to not reviewed again" do
        expect(reviewed_status).to eq false
      end
    end
  end
end

def sign_in_user(u)
  u = user
  visit "/"
  click_link "Login"
  fill_in "Email", :with => u.email
  fill_in "Password", :with => u.password
  click_button "Log in"
end

def review_asset
  g = reviewable_asset
  g.reviewed = true
  g.read_groups = ["public"]
  g.save
  g
end
