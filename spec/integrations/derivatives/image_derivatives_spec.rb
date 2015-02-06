require 'rails_helper'

RSpec.describe "image derivatives" do
  subject { AssetWithDerivatives.new(image) }
  let(:image) { Image.new }
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
