require 'rails_helper'

RSpec.describe "Updating a record" do
  let(:asset) { GenericAsset.new(id) }
  let(:reviewable_asset) { Reviewable.new(asset) }
  let(:id) { "1" }

  context "when updating an existing record that has been reviewed" do
    before do
      g = review_asset
      visit edit_record_path(:id => g.id)
    end
    context "and wanting it to be re-reviewed" do
      before do
        find(:css, "#to_review").set(true) 
        click_button "Save"
      end

      it "should set that record to not reviewed again" do
        expect(GenericAsset.find(id).workflow_metadata.reviewed).to eq false
      end
    end
  end
  context "when updating an existing record that has not been reviewed" do
    before do
      g = asset
      g.save
      visit edit_record_path(g)
    end
    context "and wanting it to be re-reviewed" do
      before do
        find(:css, "#to_review").set(true)
        click_button "Save"
      end

      it "should set that record to not reviewed again" do
        expect(GenericAsset.find(id).workflow_metadata.reviewed).to eq true
      end
    end
  end
  context "when updating an existing record that has not been reviewed" do
    before do
      g = asset
      g.save
      visit edit_record_path(g)
    end
    context "and not wanting it to be re-reviewed" do
      before do
        click_button "Save"
      end

      it "should set that record to not reviewed again" do
        expect(GenericAsset.find(id).workflow_metadata.reviewed).to eq false
      end
    end
  end
  context "when updating an existing record that has been reviewed" do
    before do
      g = review_asset 
      visit edit_record_path(g)
    end
    context "and not wanting it to be re-reviewed" do
      before do
        click_button "Save"
      end

      it "should set that record to not reviewed again" do
        expect(GenericAsset.find(id).workflow_metadata.reviewed).to eq false
      end
    end
  end
end

def review_asset
  g = reviewable_asset
  g.reviewed = true
  g.save
  g
end
