require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::DerivativeCallback do
  subject { OregonDigital::Derivatives::DerivativeCallback.new(asset) }
  let(:asset) { fake(:image) }
  let(:path) { Rails.root.join("tmp", "1.jpg").to_s }

  describe "#thumbnail_success" do
    let(:result) { subject.thumbnail_success(path) }
    before do
      result
    end
    it "should set has_thumbnail" do
      expect(asset).to have_received(:has_thumbnail=, true)
    end
    it "should set thumbnail_path" do
      expect(asset).to have_received(:thumbnail_path=, path)
    end
  end

  describe "#pyramidal_success" do
    let(:path) { Rails.root.join("tmp", "1.tiff").to_s }
    let(:result) { subject.pyramidal_success(path) }
    before do
      result
    end
    it "should set has_pyramidal" do
      expect(asset).to have_received(:has_pyramidal=, true)
    end
    it "should set pyramidal_path" do
      expect(asset).to have_received(:pyramidal_path=, path)
    end
  end

  describe "#medium_success" do
    let(:result) { subject.medium_success(path) }
    before do
      result
    end
    it "should set has_medium" do
      expect(asset).to have_received(:has_medium=, true)
    end
    it "should set medium_path" do
      expect(asset).to have_received(:medium_path=, path)
    end
  end

  describe "#pdf_success" do
    let(:asset) { fake(:document) }
    let(:result) { subject.pdf_success(path) }
    let(:path) { Rails.root.join("tmp", "documents").to_s }
    before do
      result
    end
    it "should set has_pdf_pages" do
      expect(asset).to have_received(:has_pdf_pages=, true)
    end
    it "should set pdf_pages_path" do
      expect(asset).to have_received(:pdf_pages_path=, path)
    end
  end
end
