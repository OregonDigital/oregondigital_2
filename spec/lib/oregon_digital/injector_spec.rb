require 'rails_helper'

RSpec.describe OregonDigital::Injector do
  verify_contract :injector
  let(:resource) { OregonDigital::Injector.new }
  let(:id) { "1" }

  describe "#thumbnail_path" do
    context "when given an id" do
      let(:result) { resource.thumbnail_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "thumbnails", "1", "0", "1.jpg").to_s
      end
    end
  end

  describe "#medium_path" do
    context "when given an id" do
      let(:result) { resource.medium_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "medium-images", "1", "0", "1.jpg").to_s
      end
    end
  end

  describe "#pyramidal_path" do
    context "when given an id" do
      let(:result) { resource.pyramidal_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "pyramidal", "1", "0", "1.tiff").to_s
      end
    end
  end
end
