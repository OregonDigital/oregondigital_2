require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::PersistingRunner do
  subject { described_class.new(base_runner) }
  let(:base_runner) { instance_double(OregonDigital::Derivatives::Runners::DerivativeRunner) }
  let(:asset) { object_double(Image.new) }
  describe "#run" do
    it "should call base_runner.run and persist the asset" do
      allow(base_runner).to receive(:run)
      allow(asset).to receive(:save)
      subject.run(asset)
      
      expect(base_runner).to have_received(:run).with(asset)
      expect(asset).to have_received(:save)
    end
  end

  describe "Factory" do
    subject { OregonDigital::Derivatives::PersistingRunner::Factory.new(base_factory) }
    let(:base_factory) { object_double(OregonDigital::Derivatives::Runners::RunnerList) }

    describe "#new" do
      it "should call #new on the factory and decorate it" do
        result = double("result")
        allow(base_factory).to receive(:new).and_return(result)
        result = subject.new

        expect(base_factory).to have_received(:new)
        expect(result).to be_kind_of OregonDigital::Derivatives::PersistingRunner
      end
    end
  end
end

