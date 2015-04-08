require 'rails_helper'

RSpec.describe AssetWithDerivatives do
  let(:asset) { object_double(Image.new) }
  let(:runner) { instance_double(OregonDigital::Derivatives::Runners::RunnerList) }
  subject { AssetWithDerivatives.new(asset, runner) }
  describe "#save" do
    before do
      allow(asset).to receive(:save).and_return(true)
      allow(runner).to receive(:run)
    end
    context "when the content hasn't changed" do
      before do
        allow(asset).to receive(:content_content_changed?).and_return(false)
      end
      it "should not call #run on the runner" do
        subject.save

        expect(runner).not_to have_received(:run).with(any_args)
      end
    end
    context "when the content has changed" do
      before do
        allow(asset).to receive(:content_content_changed?).and_return(true)
        allow(asset).to receive(:content_blank?).and_return(false)
      end
      it "should call #run on the runner" do
        subject.save

        expect(runner).to have_received(:run).with(subject)
      end
      context "and persistence fails" do
        before do
          allow(asset).to receive(:save).and_return(false)
        end
        # Pending - there's no way for #save to return false.
        it "should not call #run on the runner" do
          subject.save
          expect(runner).not_to have_received(:run)
        end
      end
    end
    context "when the content has changed to be blank" do
      before do
        allow(asset).to receive(:content_content_changed?).and_return(true)
        allow(asset).to receive(:content_blank?).and_return(true)
      end
      it "should not call #run on the runner" do
        subject.save

        expect(runner).not_to have_received(:run)
      end
    end
  end
end
