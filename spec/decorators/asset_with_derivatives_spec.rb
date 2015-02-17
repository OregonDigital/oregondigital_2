require 'rails_helper'

RSpec.describe AssetWithDerivatives do
  verify_contract :asset_with_derivatives
  describe "#save" do
    context "when the content hasn't changed" do
      it "should not call #run on the runner" do
        asset = fake(:image)
        stub(asset).content_content_changed? { false }
        runner = fake(:runner_list)
        unchanged_asset = AssetWithDerivatives.new(asset, runner, fake(), fake())

        unchanged_asset.save

        expect(runner).not_to have_received.run(any_args)
      end
    end
    context "when the content has changed" do
      it "should call #run on the runner" do
        asset = fake(:image)
        stub(asset).content_content_changed? { true }
        runner = fake(:runner_list)
        callback = fake(:derivative_callback)
        streamable_content = fake(:streamable_content)
        changed_asset = AssetWithDerivatives.new(asset, runner, callback, streamable_content)
        make_equal_to_fakes(streamable_content)

        changed_asset.save

        expect(runner).to have_received.run(streamable_content, callback)
      end
    end
  end
end
