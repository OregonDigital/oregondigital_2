require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::DelayedRunner do
  subject { described_class.new(runner, job_factory) }

  let(:runner) { instance_double(OregonDigital::Derivatives::Runners::RunnerList) }
  let(:job_factory) { object_double(CreateDerivativesJob) }

  describe "#run" do
    it "should run it on the job factory" do
      asset = instance_double(GenericAsset, :id => double("id"))
      allow(job_factory).to receive(:perform_later)
      marshalled_runner = double("marshalled")
      allow(Marshal).to receive(:dump).with(runner).and_return(marshalled_runner)

      subject.run(asset)

      expect(job_factory).to have_received(:perform_later).with(asset.id, marshalled_runner)
    end
  end
end

RSpec.describe OregonDigital::Derivatives::DelayedRunner::Factory do
  subject { described_class.new(base_factory, job_factory) }

  let(:base_factory) { object_double(OregonDigital::Derivatives::Runners::RunnerList) }
  let(:job_factory) { object_double(CreateDerivativesJob) }

  describe "#new" do
    it "should call #new on the factory and decorate it" do
      result = double("result")
      allow(base_factory).to receive(:new).and_return(result)
      result = subject.new

      expect(base_factory).to have_received(:new)
      expect(result).to be_kind_of OregonDigital::Derivatives::DelayedRunner
      expect(result.send(:job_factory)).to eq job_factory
    end
  end
end
