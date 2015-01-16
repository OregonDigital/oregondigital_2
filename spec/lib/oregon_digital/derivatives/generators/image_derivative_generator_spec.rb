require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Generators::ImageDerivativeGenerator do
  verify_contract :image_derivative_generator
  subject { OregonDigital::Derivatives::Generators::ImageDerivativeGenerator.new(image, file_io, thumbnail_derivative_runner, medium_derivative_runner, pyramidal_derivative_runner) }
  fake(:image, :id => "1")
  fake(:file_io) { FileContent }
  fake(:thumbnail_derivative_runner) { OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner }
  fake(:medium_derivative_runner) { OregonDigital::Derivatives::Runners::MediumImageDerivativeRunner }
  fake(:pyramidal_derivative_runner) { OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner }
  let(:real_file_content) { File.open(File.join(fixture_path, 'fixture_image.jpg'), 'rb').read }
  let(:path) { Rails.root.join("tmp", "1.jpg").to_s }
  before do
    stub(file_io).content { real_file_content }
    # Required for contracts.
    make_equal_to_fakes(subject.stream_content)
    make_equal_to_fakes(subject)
  end

  describe "#run" do
    let(:result) { subject.run }
    before do
      result
    end
    it "should generate thumbnail derivatives" do
      expect(thumbnail_derivative_runner).to have_received.run(subject.stream_content, subject)
    end
    it "should generate medium derivatives" do
      expect(medium_derivative_runner).to have_received.run(subject.stream_content, subject)
    end
    it "should generate pyramidal derivatives" do
      expect(pyramidal_derivative_runner).to have_received.run(subject.stream_content, subject)
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

  describe "#pyramidal_success" do
    let(:path) { Rails.root.join("tmp", "1.tiff").to_s }
    let(:result) { subject.pyramidal_success(path) }
    before do
      result
    end
    it "should set has_pyramidal" do
      expect(image).to have_received(:has_pyramidal=, true)
    end
    it "should set pyramidal_path" do
      expect(image).to have_received(:pyramidal_path=, path)
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
