require 'rails_helper'

RSpec.describe CreateDerivativesJob do
  subject { described_class }
  let(:derivative_injector) { OregonDigital.derivative_injector }

  describe "perform" do
    context "when a document is found" do
      it "should create derivatives" do
        id = "1"
        asset = instance_double(GenericAsset)
        allow(GenericAsset).to receive(:find).with(id).and_return(asset)
        marshalled_runner = double("marshalled")
        runner = instance_double(OregonDigital::Derivatives::Runners::RunnerList)
        allow(runner).to receive(:run).with(asset)
        allow(Marshal).to receive(:load).with(marshalled_runner).and_return(runner)

        subject.perform_now(id, marshalled_runner)

        expect(runner).to have_received(:run).with(asset)
      end
    end
  end

end
