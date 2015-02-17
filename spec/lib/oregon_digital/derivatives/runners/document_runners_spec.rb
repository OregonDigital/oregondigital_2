require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::DocumentRunners do
  subject { OregonDigital::Derivatives::Runners::DocumentRunners.new(derivative_injector) }
  let(:asset) { fake() }
  fake(:derivative_injector)
  describe "#run" do
    before do
      subject.run(asset)
    end
    it "should call #run on pdf_runner" do
      make_equal_to_fakes(asset)
      expect(derivative_injector.pdf_runner(asset.id)).to have_received.run(asset)
    end
    it "should call #run on ocr_runner" do
      make_equal_to_fakes(asset)
      expect(derivative_injector.ocr_runner(asset.id)).to have_received.run(asset)
    end
  end
end
