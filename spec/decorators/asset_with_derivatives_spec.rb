require 'rails_helper'

RSpec.describe AssetWithDerivatives do
  subject { AssetWithDerivatives.new(asset) }
  verify_contract :asset_with_derivatives
  let(:asset) { fake(:image) }
  let(:content) { fake(:FileContent) }
  let(:runner) { fake(:runner_list) { OregonDigital::Derivatives::Runners::RunnerList } }
  let(:callback) { fake(:derivative_callback) { OregonDigital::Derivatives::DerivativeCallback } }
  let(:real_content) { "real" }
  let(:stream_content) { fake(:streamable_content) }
  let(:mime_type) { "image/jpg" }
  before do
    make_equal_to_fakes(stream_content)
    make_equal_to_fakes(subject)
    stub(asset).content { content }
    stub(content).content { real_content }
    stub(content).mime_type { mime_type }
    stub(OregonDigital::Derivatives::Runners::RunnerFinder).find(asset) { runner }
    stub(OregonDigital::Derivatives::DerivativeCallback).new(subject) { callback }
    stub(StreamableContent).new(content.content, content.mime_type) { stream_content }
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
        expect(runner).to have_received.run(stream_content, callback)
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
