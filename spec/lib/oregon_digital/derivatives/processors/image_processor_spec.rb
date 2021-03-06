require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Processors::ImageProcessor do
  subject { OregonDigital::Derivatives::Processors::ImageProcessor.new(file, options) }
  let(:file) { File.open(File.join(fixture_path, "fixture_image.jpg")) }
  let(:options) do
    {
      :path => Rails.root.join("tmp", "test_image.jpg").to_s
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
    it "should create a thumbnail" do
      expect(File.exists?(options[:path])).to eq true
      image = MiniMagick::Image.open(options[:path])
      expect(image[:width]).to eq 120
      expect(image[:height]).to eq 120
    end
    context "when given an exif rotated image" do
      let(:file) { File.open(File.join(fixture_path, "rotated_image.jpg")) }
      it "should fix it up" do
        image = MiniMagick::Image.open(options[:path])
        expect(image[:width]).to eq 120
        expect(image[:height]).to eq 84
      end
    end
  end
end
