require 'rails_helper'

RSpec.describe OregonDigital::DerivativeInjector do
  verify_contract :derivative_injector
  let(:resource) { OregonDigital::DerivativeInjector.new }
  let(:id) { "1" }

  describe "#runner_list" do
    it "should be a RunnerList" do
      expect(resource.runner_list).to eq OregonDigital::Derivatives::Runners::RunnerList
    end
  end

  describe "#thumbnail_runner" do
    fake(:thumbnail_runner) { OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner }
    before do
      stub(OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner).new(resource.thumbnail_path(id), resource.derivative_callback_factory) { thumbnail_runner }
    end
    context "when given an id" do
      let(:result) { resource.thumbnail_runner(id) }
      it "should create a thumbnail runner" do
        expect(result).to eql thumbnail_runner
      end
    end
  end

  describe "#ocr_runner" do
    fake(:ocr_runner) { OregonDigital::Derivatives::Runners::OcrDerivativeRunner }
    before do
      stub(OregonDigital::Derivatives::Runners::OcrDerivativeRunner).new(resource.ocr_path(id), resource.derivative_callback_factory) { ocr_runner }
    end
    context "when given an id" do
      let(:result) { resource.ocr_runner(id) }
      it "should create a ocr runner" do
        expect(result).to eql ocr_runner
      end
    end
  end

  describe "#medium_runner" do
    fake(:medium_runner) { OregonDigital::Derivatives::Runners::MediumImageDerivativeRunner }
    before do
      stub(OregonDigital::Derivatives::Runners::MediumImageDerivativeRunner).new(resource.medium_path(id), resource.derivative_callback_factory) { medium_runner }
    end
    context "when given an id" do
      let(:result) { resource.medium_runner(id) }
      it "should create a medium runner" do
        expect(result).to eql medium_runner
      end
    end
  end

  describe "#pyramidal_runner" do
    fake(:pyramidal_runner) { OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner }
    before do
      stub(OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner).new(resource.pyramidal_path(id), resource.derivative_callback_factory) { pyramidal_runner }
    end
    context "when given an id" do
      let(:result) { resource.pyramidal_runner(id) }
      it "should create a pyramidal runner" do
        expect(result).to eql pyramidal_runner
      end
    end
  end

  describe "#pdf_runner" do
    fake(:pdf_runner) { OregonDigital::Derivatives::Runners::PdfRunner }
    before do
      stub(OregonDigital::Derivatives::Runners::PdfRunner).new(resource.pdf_path(id), resource.derivative_callback_factory) { pdf_runner }
    end
    context "when given an id" do
      let(:result) { resource.pdf_runner(id) }
      it "should create a pdf runner" do
        expect(result).to eql pdf_runner
      end
    end
  end

  describe "#thumbnail_path" do
    context "when given an id" do
      let(:result) { resource.thumbnail_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "thumbnails", "1", "0", "1.jpg").to_s
      end
    end
  end

  describe "#ocr_path" do
    context "when given an id" do
      let(:result) { resource.ocr_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "documents", "1", "0", "1", "ocr.html").to_s
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

  describe "#pdf_path" do
    context "when given an id" do
      let(:result) { resource.pdf_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "documents", "1", "0", "1").to_s
      end
    end
  end
end
