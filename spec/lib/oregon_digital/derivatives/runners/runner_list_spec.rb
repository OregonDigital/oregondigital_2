require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::RunnerList do
  verify_contract :runner_list
  fake(:runner) { OregonDigital::Derivatives::Runners::DerivativeRunner }
  fake(:image)

  subject { OregonDigital::Derivatives::Runners::RunnerList.new([runner]) }
  describe "#run" do
    before do
      subject.run(image)
    end
    it "should call #run on passed runners" do
      expect(runner).to have_received.run(image)
    end
  end
end
