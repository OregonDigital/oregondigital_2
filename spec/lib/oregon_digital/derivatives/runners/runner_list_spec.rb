require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::RunnerList do
  let(:runner) { instance_double(OregonDigital::Derivatives::Runners::DerivativeRunner) }
  let(:image) { object_double(Image.new) }

  subject { OregonDigital::Derivatives::Runners::RunnerList.new([runner]) }
  describe "#run" do
    before do
      allow(runner).to receive(:run)

      subject.run(image)
    end
    it "should call #run on passed runners" do
      expect(runner).to have_received(:run).with(image)
    end
  end
end
