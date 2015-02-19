require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::RunnerFinder do
  subject { OregonDigital::Derivatives::RunnerFinder.new(runner_builder) }
  let(:asset) { fake(:image, :id => "1") }
  let(:runner_builder) { OregonDigital.derivative_injector }

  describe "#find" do
    context "when derivatives are set" do
      before do
        stub(asset).derivatives { [:thumbnail, :medium, :pyramidal] }
      end
      it "should use runner_builder to build" do
        subject.find(asset)

        asset.derivatives.each do |derivative|
          expect(runner_builder).to have_received(:"#{derivative}_runner", asset.id)
        end
      end
      it "should return a runner list" do
        expect(subject.find(asset)).to be_a runner_builder.runner_list
      end
      it "should return appropriate runners" do
        expect(subject.find(asset).to_a).to eq [runner_builder.thumbnail_runner("1"),
                                          runner_builder.medium_runner("1"),
                                          runner_builder.pyramidal_runner("1")
        ]
      end
    end
  end
end
