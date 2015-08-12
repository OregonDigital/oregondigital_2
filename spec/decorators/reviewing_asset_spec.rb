require 'rails_helper'

RSpec.describe ReviewingAsset do
  subject { described_class.new(asset) }

  describe "#review!" do
    before do
      subject.review!
    end
    context "when given an unreviewed and unpublic asset" do
      let(:asset) { build_asset(is_public: false, is_reviewed: false) }
      it "should call save on the asset" do
        expect(asset).to have_received(:save)
      end
      it "should set it public" do
        expect(asset).to have_received(:public=).with(true)
      end
      it "should set it reviewed" do
        expect(asset).to have_received(:reviewed=).with(true)
      end
    end
    context "when given a public and unreviewed asset" do
      let(:asset) { build_asset(is_public: true, is_reviewed: false) }
      it "should call save on the asset" do
        expect(asset).to have_received(:save)
      end
      it "should set it public" do
        expect(asset).to have_received(:public=).with(true)
      end
      it "should set it reviewed" do
        expect(asset).to have_received(:reviewed=).with(true)
      end
    end
  end
  describe "#unreview!" do
    before do
      subject.unreview!
    end
    context "when given an unreviewed asset" do
      let(:asset) { build_asset(is_public: false, is_reviewed: false) }
      it "should call save on the asset" do
        expect(asset).to have_received(:save)
      end
      it "should set it to not reviewed" do
        expect(asset).to have_received(:reviewed=).with(false)
      end
    end
    context "when given a reviewed asset" do
      let(:asset) { build_asset(is_public: true, is_reviewed: true) }
      it "should call save on the asset" do
        expect(asset).to have_received(:save)
      end
      it "should set it unreviewed" do
        expect(asset).to have_received(:reviewed=).with(false)
      end
    end
  end
 

  describe "#class" do
    let(:asset) { GenericAsset.new }
    it "should delegate down" do
      expect(subject.class).to eq asset.class
    end
  end

  def build_asset(is_public:, is_reviewed:)
    i = object_double(Reviewable.new(GenericAsset.new))
    allow(i).to receive(:save)
    allow(i).to receive(:public?).and_return(is_public)
    allow(i).to receive(:public=)
    allow(i).to receive(:reviewed?).and_return(is_reviewed)
    allow(i).to receive(:reviewed=)
    i
  end
end
