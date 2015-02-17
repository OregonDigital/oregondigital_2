require 'rails_helper'

RSpec.describe AssetWithDerivatives do
  verify_contract :asset_with_derivatives
  let(:asset) { fake(:image) }
  let(:runner) { fake(:runner_list) }

  subject { AssetWithDerivatives.new(asset, runner) }
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
        stub(asset).content_blank? { false }
      end
      it "should call #run on the runner" do
        make_equal_to_fakes(subject)
        subject.save

        expect(runner).to have_received.run(subject)
      end
      context "and persistence fails" do
        before do
          stub(asset).save { false }
        end
        # Pending - there's no way for #save to return false.
        xit "should not call #run on the runner" do
          subject.save

          expect(runner).not_to have_received.run(any_args)
        end
      end
    end
    context "when the content has changed to be blank" do
      before do
        stub(asset).content_content_changed? { true }
        stub(asset).content_blank? { true }
      end
      it "should not call #run on the runner" do
        subject.save

        expect(runner).not_to have_received.run(any_args)
      end
    end
  end
end
