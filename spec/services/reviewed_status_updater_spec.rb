require 'rails_helper'

RSpec.describe ReviewedStatusUpdater do
  let(:updater) { described_class.new(id, "1") }
  let(:asset) { GenericAsset.new(id) }
  let(:reviewable_asset) { Reviewable.new(asset) }
  let(:id) { "1" }

  describe "#update_review_status!" do
    context "if an asset exists and has been reviewed" do
      before do
        review_asset
      end
      it "should update the reviewed status" do
        expect(GenericAsset.find(id).workflow_metadata.reviewed).to eq true

        updater.update_review_status!

        expect(GenericAsset.find(id).workflow_metadata.reviewed).to eq false
      end
    end 
  end

  

  def review_asset
    g = reviewable_asset
    g.reviewed = true
    g.save
    g
  end
end
