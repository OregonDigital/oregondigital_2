require 'rails_helper'

RSpec.describe "image derivatives" do
  subject { AssetWithDerivatives.new(image, runners, derivative_callback, stream_content) }
  let(:image) { Image.new }
  let(:derivative_callback) { OregonDigital::Derivatives::DerivativeCallback.new(image) }
  let(:stream_content) { StreamableContent.new(image.content.content, image.content.mime_type) }
  let(:runners) { OregonDigital::Derivatives::Runners::RunnerFinder.find(image) }
  let(:file) { File.open(File.join(fixture_path, "fixture_image.tiff")) }
  before do
    Bogus.clear
    image.content.content = file
    image.content.mime_type = "image/tiff"
  end
  it "should work" do
    expect{subject.save}.not_to raise_error
    expect(image.workflow_metadata.thumbnail_path).not_to be_blank
    expect(image.workflow_metadata.medium_path).not_to be_blank
    expect(image.workflow_metadata.pyramidal_path).not_to be_blank
  end
end
