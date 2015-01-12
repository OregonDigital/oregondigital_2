require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::MediumImageDerivativeRunner do
  verify_contract :medium_derivative_runner
  subject { OregonDigital::Derivatives::MediumImageDerivativeRunner.new(file, path, callback) }
  let(:file) { fake(:file) { File } }
  let(:callback) { fake(:image_derivative_generator) { OregonDigital::Derivatives::ImageDerivativeGenerator } }
  let(:path) { Rails.root.join("tmp", "1.jpg").to_s }
  fake(:image_processor) { OregonDigital::Derivatives::ImageProcessor }
  describe "#run" do
    let(:result) { subject.run }
    let(:default_options) do
      {
        :size => "680x680>",
        :format => 'jpeg',
        :quality => '75',
        :path => path
      }
    end
    before do
      stub(OregonDigital::Derivatives::ImageProcessor).new(file, default_options) { image_processor }
      result
    end
    it "should call #thumbnail_success on the callback" do
      expect(callback).to have_received.medium_success(path)
    end
    it "should call image processor" do
      expect(image_processor).to have_received.run
    end
  end
end
