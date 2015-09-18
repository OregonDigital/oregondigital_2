require 'rails_helper'

RSpec.describe "video derivatives", :perform_enqueued => true do
  it "should work" do
    video = Video.new
    file = File.open(File.join(fixture_path, "fixture_video.ogv"))
    video.content.content = file
    video.content.mime_type = "video/flv"
    asset_with_derivatives = AssetWithDerivativesFactory.new(video)

    expect{asset_with_derivatives.save}.not_to raise_error
    reloaded_asset = Video.find(video.id)
    expect(reloaded_asset.workflow_metadata.thumbnail_path).to include video.id
    expect(reloaded_asset.workflow_metadata.thumbnail_path).not_to be_blank
    expect(reloaded_asset.workflow_metadata.to_h).not_to eq ({})
  end
end
