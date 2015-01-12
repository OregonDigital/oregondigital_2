require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::ImageDerivativeGenerator do
  verify_contract :image_derivative_generator
  subject { OregonDigital::Derivatives::ImageDerivativeGenerator.new(image, file_io) }
  fake(:image, :id => "1")
  fake(:file_io) { FileContent }
  fake(:thumbnail_derivative_runner) { OregonDigital::Derivatives::ThumbnailDerivativeRunner }
  let(:real_file_content) { File.open(File.join(fixture_path, 'fixture_image.jpg'), 'rb').read }
  let(:injector) { OregonDigital.inject }
  before do
    stub(file_io).content { real_file_content }
    stub(OregonDigital::Derivatives::ThumbnailDerivativeRunner).new(any(StringIO), injector.thumbnail_path(image.id), subject) { thumbnail_derivative_runner }
  end

  describe "#run" do
    let(:result) { subject.run }
    before do
      result
    end
    it "should generate thumbnail derivatives" do
      expect(thumbnail_derivative_runner).to have_received.run
    end
  end

  describe "#thumbnail_success" do
    let(:result) { subject.thumbnail_success(Rails.root.join("tmp", "1.jpg").to_s) }
    before do
      result
    end
    it "should set has_thumbnail" do
      expect(image).to have_received(:has_thumbnail=, true)
    end
  end
end
