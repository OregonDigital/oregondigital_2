require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::MediumImageDerivativeRunner do
  verify_contract :medium_derivative_runner
  subject { OregonDigital::Derivatives::Runners::MediumImageDerivativeRunner.new(path, callback_factory) }
  let(:callback_factory) { fake() }
  fake(:derivative_callback)
  let(:path) { Rails.root.join("tmp", "1.jpg").to_s }
  fake(:image_processor) { OregonDigital::Derivatives::Processors::ImageProcessor }

  describe "#run" do
    let(:asset) { fake(:image, :streamable_content => file) }
    let(:file) { fake(:file) { File } }
    before do
      stub(callback_factory).new(asset) { derivative_callback }
      stub(OregonDigital::Derivatives::Processors::ImageProcessor).new(file, anything) { image_processor }
      subject.run(asset)
    end
    it "should call #success on the callback" do
      expect(derivative_callback).to have_received.success(:medium, path)
    end
    it "should call image processor" do
      expect(image_processor).to have_received.run
    end
  end
end
