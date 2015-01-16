require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::PyramidalDerivativeRunner do
  verify_contract :pyramidal_derivative_runner
  subject { OregonDigital::Derivatives::PyramidalDerivativeRunner.new(file, path, callback) }
  let(:file) { fake(:file) { File } }
  let(:callback) { fake(:image_derivative_generator) { OregonDigital::Derivatives::ImageDerivativeGenerator } }
  let(:path) { Rails.root.join("tmp", "1.tiff").to_s }

  describe "#run" do
    let(:result) { subject.run }
    fake(:pyramidal_processor) { OregonDigital::Derivatives::PyramidalProcessor }
    let(:options) do
      {
        :quality => 75,
        :tile_size => 256,
        :path => path
      }
    end
    before do
      stub(OregonDigital::Derivatives::PyramidalProcessor).new(file, options) { pyramidal_processor }
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
