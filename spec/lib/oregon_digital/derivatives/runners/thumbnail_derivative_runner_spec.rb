require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner do
  subject { OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner.new(path, callback_factory) }

  let(:callback_factory) { double("callback factory") }
  let(:derivative_callback) { instance_double(OregonDigital::Derivatives::DerivativeCallback) }
  let(:path) { Rails.root.join("tmp", "1.jpg").to_s }
  let(:image_processor) { instance_double(OregonDigital::Derivatives::Processors::ImageProcessor) }

  describe "#run" do
    let(:asset) { object_double(Image.new, :streamable_content => file) }
    let(:file) { instance_double(File) }
    before do
      allow(callback_factory).to receive(:new).with(asset).and_return(derivative_callback)
      allow(OregonDigital::Derivatives::Processors::ImageProcessor).to receive(:new).with(file, anything).and_return(image_processor)
      allow(derivative_callback).to receive(:success)
      allow(image_processor).to receive(:run)
      subject.run(asset)
    end
    it "should call #success on the callback" do
      expect(derivative_callback).to have_received(:success).with(:thumbnail, path)
    end
    it "should call image processor" do
      expect(image_processor).to have_received(:run)
    end
  end
end
