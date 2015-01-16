require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner do
  verify_contract :pyramidal_derivative_runner
  subject { OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner.new(path) }
  let(:file) { fake(:file) { File } }
  let(:callback) { fake(:image_derivative_generator) { OregonDigital::Derivatives::Generators::ImageDerivativeGenerator } }
  let(:path) { Rails.root.join("tmp", "1.tiff").to_s }

  describe "#run" do
    let(:result) { subject.run(file, callback) }
    fake(:pyramidal_processor) { OregonDigital::Derivatives::Processors::PyramidalProcessor }
    let(:options) do
      {
        :quality => 75,
        :tile_size => 256,
        :path => path
      }
    end
    before do
      stub(OregonDigital::Derivatives::Processors::PyramidalProcessor).new(file, options) { pyramidal_processor }
      result
    end
    it "should run pyramidal generator" do
      expect(pyramidal_processor).to have_received.run
    end
    it "should call #pyramidal_success on the callback" do
      expect(callback).to have_received.pyramidal_success(path)
    end
  end
end
