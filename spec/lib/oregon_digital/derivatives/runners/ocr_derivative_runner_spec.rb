require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::OcrDerivativeRunner do
  subject { OregonDigital::Derivatives::Runners::OcrDerivativeRunner.new(path, callback_factory) }
  let(:callback_factory) { double("callback factory") }
  let(:derivative_callback) { instance_double(OregonDigital::Derivatives::DerivativeCallback) }
  let(:path) { Rails.root.join("tmp", "ocr.html").to_s }

  describe "#run" do
    let(:asset) { object_double(Image.new, :streamable_content => file) }
    let(:file) { instance_double(File) }
    let(:ocr_processor) { instance_double(OregonDigital::Derivatives::Processors::OcrProcessor) }
    before do
      allow(ocr_processor).to receive(:run)
      allow(derivative_callback).to receive(:success)
      allow(callback_factory).to receive(:new).with(asset).and_return(derivative_callback)
      allow(OregonDigital::Derivatives::Processors::OcrProcessor).to receive(:new).with(file, anything).and_return(ocr_processor)
      subject.run(asset)
    end
    it "should run ocr generator" do
      expect(ocr_processor).to have_received(:run)
    end
    it "should call #ocr_success on the callback" do
      expect(derivative_callback).to have_received(:success).with(:ocr, path)
    end
  end
end
