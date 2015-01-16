require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner do
  verify_contract :thumbnail_derivative_runner
  subject { OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner.new(path) }
  let(:file) { fake(:file) { File } }
  let(:callback) { fake(:image_derivative_generator) { OregonDigital::Derivatives::Generators::ImageDerivativeGenerator } }
  let(:path) { Rails.root.join("tmp", "1.jpg").to_s }
  fake(:image_processor) { OregonDigital::Derivatives::Processors::ImageProcessor }
  describe "#run" do
    let(:result) { subject.run(file, callback) }
    let(:default_options) do
      {
        :size => "120x120>",
        :format => 'jpeg',
        :quality => '75',
        :path => path
      }
    end
    before do
      stub(OregonDigital::Derivatives::Processors::ImageProcessor).new(file, default_options) { image_processor }
      result
    end
    it "should call #thumbnail_success on the callback" do
      expect(callback).to have_received.thumbnail_success(path)
    end
    it "should call image processor" do
      expect(image_processor).to have_received.run
    end
  end
end
