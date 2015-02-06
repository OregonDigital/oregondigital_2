require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::RunnerList do
  verify_contract :runner_list
  fake(:runner) { OregonDigital::Derivatives::Runners::DerivativeRunner }
  let(:stream_content) { fake() }
  let(:callback) { fake(:asset_with_derivatives) { AssetWithDerivatives } }

  subject { OregonDigital::Derivatives::Runners::RunnerList.new([runner]) }
  describe "#run" do
    let(:result) { subject.run(stream_content, callback) }
    before do
      result
    end
    it "should call #run on passed runners" do
      expect(runner).to have_received.run(stream_content, callback)
    end
  end
end
