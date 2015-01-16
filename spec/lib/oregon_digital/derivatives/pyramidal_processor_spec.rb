require 'rails_helper'
require 'vips'

RSpec.describe OregonDigital::Derivatives::PyramidalProcessor do
  verify_contract :pyramidal_processor
  subject { OregonDigital::Derivatives::PyramidalProcessor.new(file, options) }
  let(:file) { File.open(File.join(fixture_path, "fixture_image.tiff")) }
  let(:options) do
    {
      :path => Rails.root.join("tmp", "test_image.tiff").to_s
    }
  end

  describe "#run" do
    let(:result) { subject.run }
    before do
      result
    end
    after do
      File.delete(options[:path]) if File.exists?(options[:path])
    end
    it "should create a pyramidal tiff" do
      expect(File.exists?(options[:path])).to eq true
    end
    context "with a 16-bit tiff" do
      let(:file) { File.open(File.join(fixture_path, "tiff_16.tiff")) }
      it "should create a pyramidal tiff" do
        expect(File.exists?(options[:path])).to eq true
      end
    end
  end
end
