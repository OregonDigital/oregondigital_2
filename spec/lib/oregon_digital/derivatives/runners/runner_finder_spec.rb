require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::RunnerFinder do
  verify_contract :runner_finder
  let(:resource) { OregonDigital::Derivatives::Runners::RunnerFinder }

  describe ".find" do
    let(:result) { resource.find(asset) }
    let(:asset) { fake(:image) }
    fake(:derivative_injector)
    context "when given an image" do
      it "should return a runner_list" do
        expect(result).to be_kind_of OregonDigital::Derivatives::Runners::RunnerList
      end
      it "should have three runners" do
        expect(result.length).to eq 3
      end
      it "should have a thumbnail runner" do
        expect(result).to include derivative_injector.thumbnail_runner(asset.id)
      end
      it "should have a medium runner" do
        expect(result).to include derivative_injector.medium_runner(asset.id)
      end
      it "should have a pyramidal runner" do
        expect(result).to include derivative_injector.pyramidal_runner(asset.id)
      end
    end
    context "when given a document" do
      let(:asset) { fake(:document) }
      it "should have one runner" do
        expect(result.length).to eq 1
      end
      it "should have a pdf runner" do
        expect(result).to include derivative_injector.pdf_runner(asset.id)
      end
    end
    context "when given something with no runners" do
      before do
        class BadClass
        end
      end
      after do
        Object.send(:remove_const, :BadClass)
      end
      let(:asset) { BadClass.new }
      it "should return a NullRunner" do
        expect(result.length).to eq 1
        expect(result.first).to be_kind_of OregonDigital::Derivatives::Runners::NullRunner
      end
    end
  end
end
