require 'rails_helper'

RSpec.describe AssetWithDerivatives do
  verify_contract :asset_with_derivatives
  let(:asset) { fake(:image, :streamable_content => streamable_content) }
  let(:runner_finder) do
    r = fake()
    stub(r).find(asset) { runner }
    r
  end
  let(:runner) { fake(:runner_list) }
  let(:callback) { fake(:derivative_callback) }
  let(:streamable_content) { fake(:streamable_content) }

  subject { AssetWithDerivatives.new(asset, runner_finder, callback) }
  describe "#save" do
    context "when the content hasn't changed" do
      before do
        stub(asset).content_content_changed? { false }
      end
      it "should not call #run on the runner" do
        subject.save

        expect(runner).not_to have_received.run(any_args)
      end
    end
    context "when the content has changed" do
      before do
        stub(asset).content_content_changed? { true }
      end
      it "should call #run on the runner" do
        make_equal_to_fakes(streamable_content)

        subject.save

        expect(runner).to have_received.run(streamable_content, callback)
      end
    end
  end
end
