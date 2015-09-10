require 'rails_helper'

RSpec.describe "Audio derivatives", :perform_enqueued => true do
  it "should create the proper audio derivatives for mp3" do
    audio = Audio.new
    file = File.open(File.join(fixture_path, "fixture_sound.wav"))
    audio.content.content = file
    audio.content.mime_type = "audio/mp3"
    asset_with_derivatives = AssetWithDerivativesFactory.new(audio)

    expect{asset_with_derivatives.save}.not_to raise_error
    reloaded_asset = Audio.find(audio.id)
    expect(reloaded_asset.workflow_metadata.mp3_path).to include audio.id
    expect(reloaded_asset.workflow_metadata.mp3_path).not_to be_blank
    expect(reloaded_asset.workflow_metadata.to_h).not_to eq ({})
  end

  it "should create the proper audio derivatives for ogg" do
    audio = Audio.new
    file = File.open(File.join(fixture_path, "fixture_sound.wav"))
    audio.content.content = file
    audio.content.mime_type = "audio/ogg"
    asset_with_derivatives = AssetWithDerivativesFactory.new(audio)

    expect{asset_with_derivatives.save}.not_to raise_error
    reloaded_asset = Audio.find(audio.id)
    expect(reloaded_asset.workflow_metadata.ogg_path).to include audio.id
    expect(reloaded_asset.workflow_metadata.ogg_path).not_to be_blank
    expect(reloaded_asset.workflow_metadata.to_h).not_to eq ({})
  end
end
