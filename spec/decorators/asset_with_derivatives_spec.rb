require 'rails_helper'

RSpec.describe AssetWithDerivatives do
  subject { AssetWithDerivatives.new(asset, runner) }
  verify_contract :asset_with_derivatives
  let(:asset) { fake(:image) }
  let(:content) { fake(:FileContent) }
  let(:runner) { fake(:runner) { OregonDigital::Derivatives::Runners::RunnerList } }
  let(:real_content) { "real" }
  let(:stream_content) { fake() }
  before do
    stub(asset).content { content }
    stub(content).content { real_content }
    stub(StringIO).new(content.content) { stream_content }
  end
  describe "#save" do
    context "when the content hasn't changed" do
      before do
        stub(content).content_changed? { false }
        subject.save
      end
      it "should not call #run on the runner" do
        expect(runner).not_to have_received.run(any_args)
      end
    end
    context "when the content has changed" do
      before do
        stub(content).content_changed? { true }
        subject.save
      end
      it "should call #run on the runner" do
        expect(runner).to have_received.run(stream_content, subject)
      end
      context "and the content is blank" do
        let(:real_content) { "" }
        it "should not call #run on the runner" do
          expect(runner).not_to have_received.run(any_args)
        end
      end
    end
  end
end
