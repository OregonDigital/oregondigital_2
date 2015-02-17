require 'rails_helper'

RSpec.describe "image derivatives" do
  it "should work" do
    Bogus.clear
    image = Image.new
    file = File.open(File.join(fixture_path, "fixture_image.tiff"))
    image.content.content = file
    image.content.mime_type = "image/tiff"
    asset_with_derivatives = DerivativeCreationFacade.call(image, OregonDigital.derivative_injector)

    expect{asset_with_derivatives.save}.not_to raise_error
    expect(image.workflow_metadata.thumbnail_path).to include image.id
    expect(image.workflow_metadata.thumbnail_path).not_to be_blank
    expect(image.workflow_metadata.medium_path).not_to be_blank
    expect(image.workflow_metadata.pyramidal_path).not_to be_blank
  end
end
