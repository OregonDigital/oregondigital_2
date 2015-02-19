require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner do
  verify_contract :pyramidal_derivative_runner
  subject { OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner.new(path, callback_factory) }
  let(:callback_factory) { fake() }
  fake(:derivative_callback)
  let(:path) { Rails.root.join("tmp", "1.tiff").to_s }

  describe "#run" do
    let(:asset) { fake(:image, :streamable_content => file) }
    fake(:file)
    fake(:pyramidal_processor) { OregonDigital::Derivatives::Processors::PyramidalProcessor }
    before do
      stub(callback_factory).new(asset) { derivative_callback }
      stub(OregonDigital::Derivatives::Processors::PyramidalProcessor).new(file, anything) { pyramidal_processor }
      subject.run(asset)
    end
    it "should run pyramidal generator" do
      expect(pyramidal_processor).to have_received.run
    end
    it "should call #success on the callback" do
      expect(derivative_callback).to have_received.success(:pyramidal, path)
    end
  end
end
