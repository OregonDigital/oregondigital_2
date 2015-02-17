require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner do
  verify_contract :thumbnail_derivative_runner
  subject { OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner.new(path, callback_factory) }

  let(:callback_factory) { fake() }
  fake(:derivative_callback)
  let(:path) { Rails.root.join("tmp", "1.jpg").to_s }
  fake(:image_processor) { OregonDigital::Derivatives::Processors::ImageProcessor }

  describe "#run" do
    let(:asset) { fake(:image, :streamable_content => file) }
    fake(:file)
    before do
      stub(callback_factory).new(asset) { derivative_callback }
      stub(OregonDigital::Derivatives::Processors::ImageProcessor).new(file, anything) { image_processor }
      subject.run(asset)
    end
    it "should call #thumbnail_success on the callback" do
      expect(derivative_callback).to have_received.thumbnail_success(path)
    end
    it "should call image processor" do
      expect(image_processor).to have_received.run
    end
  end
end
