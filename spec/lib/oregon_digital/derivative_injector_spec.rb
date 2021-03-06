require 'rails_helper'

RSpec.describe OregonDigital::DerivativeInjector do
  let(:resource) { OregonDigital::DerivativeInjector.new }
  let(:id) { "1" }

  describe "#runner_list" do
    it "should be a RunnerList" do
      expect(resource.runner_list).to be_kind_of OregonDigital::Derivatives::DelayedRunner::Factory
      expect(resource.runner_list.send(:base_runner_factory)).to be_kind_of OregonDigital::Derivatives::PersistingRunner::Factory
      expect(resource.runner_list.send(:base_runner_factory).send(:base_factory)).to eq OregonDigital::Derivatives::Runners::RunnerList
    end
  end

  describe "#thumbnail_runner" do
    let(:thumbnail_runner) { instance_double(OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner) }
    before do
      allow(OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner).to receive(:new).with(resource.thumbnail_path(id), resource.derivative_callback_factory).and_return(thumbnail_runner)
    end
    context "when given an id" do
      let(:result) { resource.thumbnail_runner(id) }
      it "should create a thumbnail runner" do
        expect(result).to eql thumbnail_runner
      end
    end
  end

  describe "#ocr_runner" do
    let(:ocr_runner) { instance_double(OregonDigital::Derivatives::Runners::OcrDerivativeRunner) }
    before do
      allow(OregonDigital::Derivatives::Runners::OcrDerivativeRunner).to receive(:new).with(resource.ocr_path(id), resource.derivative_callback_factory).and_return(ocr_runner)
    end
    context "when given an id" do
      let(:result) { resource.ocr_runner(id) }
      it "should create a ocr runner" do
        expect(result).to eql ocr_runner
      end
    end
  end

  describe "#medium_runner" do
    let(:medium_runner) { instance_double(OregonDigital::Derivatives::Runners::MediumImageDerivativeRunner) }
    before do
      allow(OregonDigital::Derivatives::Runners::MediumImageDerivativeRunner).to receive(:new).with(resource.medium_path(id), resource.derivative_callback_factory).and_return(medium_runner)
    end
    context "when given an id" do
      let(:result) { resource.medium_runner(id) }
      it "should create a medium runner" do
        expect(result).to eql medium_runner
      end
    end
  end

  describe "#pyramidal_runner" do
    let(:pyramidal_runner) { instance_double(OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner) }
    before do
      allow(OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner).to receive(:new).with(resource.pyramidal_path(id), resource.derivative_callback_factory).and_return(pyramidal_runner)
    end
    context "when given an id" do
      let(:result) { resource.pyramidal_runner(id) }
      it "should create a pyramidal runner" do
        expect(result).to eql pyramidal_runner
      end
    end
  end

  describe "#pdf_pages_runner" do
    let(:pdf_runner) { instance_double(OregonDigital::Derivatives::Runners::PdfRunner) }
    before do
      allow(OregonDigital::Derivatives::Runners::PdfRunner).to receive(:new).with(resource.pdf_path(id), resource.derivative_callback_factory).and_return(pdf_runner)
    end
    context "when given an id" do
      let(:result) { resource.pdf_pages_runner(id) }
      it "should create a pdf runner" do
        expect(result).to eql pdf_runner
      end
    end
  end

  describe "#ogg_runner" do
    let(:ogg_runner) { instance_double(OregonDigital::Derivatives::Runners::OggDerivativeRunner) }
    before do
      allow(OregonDigital::Derivatives::Runners::OggDerivativeRunner).to receive(:new).with(resource.ogg_path(id), resource.derivative_callback_factory).and_return(ogg_runner)
    end
    context "when given an id" do
      let(:result) { resource.ogg_runner(id) }
      it "should create a ogg runner" do
        expect(result).to eql ogg_runner
      end
    end
  end

  describe "#mp3_runner" do
    let(:mp3_runner) { instance_double(OregonDigital::Derivatives::Runners::Mp3DerivativeRunner) }
    before do
      allow(OregonDigital::Derivatives::Runners::Mp3DerivativeRunner).to receive(:new).with(resource.mp3_path(id), resource.derivative_callback_factory).and_return(mp3_runner)
    end
    context "when given an id" do
      let(:result) { resource.mp3_runner(id) }
      it "should create a mp3 runner" do
        expect(result).to eql mp3_runner
      end
    end
  end

  describe "#thumbnail_path" do
    context "when given an id" do
      let(:result) { resource.thumbnail_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "thumbnails", "1", "0", "1.jpg")
      end
    end
  end

  describe "#ocr_path" do
    context "when given an id" do
      let(:result) { resource.ocr_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "documents", "1", "0", "1", "ocr.html")
      end
    end
  end

  describe "#medium_path" do
    context "when given an id" do
      let(:result) { resource.medium_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "medium-images", "1", "0", "1.jpg")
      end
    end
  end

  describe "#pyramidal_path" do
    context "when given an id" do
      let(:result) { resource.pyramidal_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "pyramidal", "1", "0", "1.tiff")
      end
    end
  end

  describe "#pdf_path" do
    context "when given an id" do
      let(:result) { resource.pdf_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "documents", "1", "0", "1")
      end
    end
  end
end
