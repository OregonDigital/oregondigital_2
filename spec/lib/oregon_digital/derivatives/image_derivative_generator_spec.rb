require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::ImageDerivativeGenerator do
  verify_contract :image_derivative_generator
  subject { OregonDigital::Derivatives::ImageDerivativeGenerator.new(image, file_io) }
  fake(:image, :id => "1")
  fake(:file_io) { FileContent }
  fake(:thumbnail_derivative_runner) { OregonDigital::Derivatives::ThumbnailDerivativeRunner }
  fake(:medium_derivative_runner) { OregonDigital::Derivatives::MediumImageDerivativeRunner }
  let(:real_file_content) { File.open(File.join(fixture_path, 'fixture_image.jpg'), 'rb').read }
  let(:injector) { OregonDigital.inject }
  let(:path) { Rails.root.join("tmp", "1.jpg").to_s }
  before do
    stub(file_io).content { real_file_content }
    stub(OregonDigital::Derivatives::ThumbnailDerivativeRunner).new(any(StringIO), injector.thumbnail_path(image.id), subject) { thumbnail_derivative_runner }
    stub(OregonDigital::Derivatives::MediumImageDerivativeRunner).new(any(StringIO), injector.medium_path(image.id), subject) { medium_derivative_runner }
  end

  describe "#run" do
    let(:result) { subject.run }
    before do
      result
    end
    it "should generate thumbnail derivatives" do
      expect(thumbnail_derivative_runner).to have_received.run
    end
    it "should generate medium derivatives" do
      expect(medium_derivative_runner).to have_received.run
    end
  end

  describe "#thumbnail_success" do
    let(:result) { subject.thumbnail_success(path) }
    before do
      result
    end
    it "should set has_thumbnail" do
      expect(image).to have_received(:has_thumbnail=, true)
    end
    it "should set thumbnail_path" do
      expect(image).to have_received(:thumbnail_path=, path)
    end
  end

  describe "#medium_success" do
    let(:result) { subject.medium_success(path) }
    before do
      result
    end
    it "should set has_medium" do
      expect(image).to have_received(:has_medium=, true)
    end
    it "should set medium_path" do
      expect(image).to have_received(:medium_path=, path)
    end
  end
end
