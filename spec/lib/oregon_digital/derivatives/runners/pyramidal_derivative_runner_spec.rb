require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner do
  subject { OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner.new(path, callback_factory) }
  let(:callback_factory) { double("callback factory") }
  let(:derivative_callback) { instance_double(OregonDigital::Derivatives::DerivativeCallback) }
  let(:path) { Rails.root.join("tmp", "1.tiff").to_s }

  describe "#run" do
    let(:asset) { object_double(Image.new, :streamable_content => file) }
    let(:file) { instance_double(File) }
    let(:pyramidal_processor) { instance_double(OregonDigital::Derivatives::Processors::PyramidalProcessor) }
    before do
      allow(callback_factory).to receive(:new).with(asset).and_return(derivative_callback)
      allow(OregonDigital::Derivatives::Processors::PyramidalProcessor).to receive(:new).with(file, anything).and_return(pyramidal_processor)
      allow(derivative_callback).to receive(:success)
      allow(pyramidal_processor).to receive(:run)
      subject.run(asset)
    end
    it "should run pyramidal generator" do
      expect(pyramidal_processor).to have_received(:run)
    end
    it "should call #success on the callback" do
      expect(derivative_callback).to have_received(:success).with(:pyramidal, path)
    end
  end
end
