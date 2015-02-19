require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::OcrDerivativeRunner do
  verify_contract :ocr_derivative_runner
  subject { OregonDigital::Derivatives::Runners::OcrDerivativeRunner.new(path, callback_factory) }
  let(:callback_factory) { fake() }
  fake(:derivative_callback)
  let(:path) { Rails.root.join("tmp", "ocr.html").to_s }

  describe "#run" do
    let(:asset) { fake(:image, :streamable_content => file) }
    fake(:file)
    fake(:ocr_processor) { OregonDigital::Derivatives::Processors::OcrProcessor }
    before do
      stub(callback_factory).new(asset) { derivative_callback }
      stub(OregonDigital::Derivatives::Processors::OcrProcessor).new(file, anything) { ocr_processor }
      subject.run(asset)
    end
    it "should run ocr generator" do
      expect(ocr_processor).to have_received.run
    end
    it "should call #ocr_success on the callback" do
      expect(derivative_callback).to have_received.success(:ocr, path)
    end
  end
end
