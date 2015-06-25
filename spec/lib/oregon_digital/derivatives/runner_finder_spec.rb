require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::RunnerFinder do
  subject { OregonDigital::Derivatives::RunnerFinder.new(runner_builder) }
  let(:asset) { object_double(Image.new, :id => "1") }
  let(:runner_builder) { OregonDigital.derivative_injector }
  before do
    allow(runner_builder).to receive(:thumbnail_runner).with("1").and_return(double("thumbnail runner"))
    allow(runner_builder).to receive(:medium_runner).with("1").and_return(double("medium runner"))
    allow(runner_builder).to receive(:pyramidal_runner).with("1").and_return(double("pyramidal runner"))
  end

  describe "#find" do
    context "when derivatives are set" do
      before do
        allow(asset).to receive(:derivatives).and_return([:thumbnail, :medium, :pyramidal])
      end
      it "should use runner_builder to build" do
        subject.find(asset)

        asset.derivatives.each do |derivative|
          expect(runner_builder).to have_received(:"#{derivative}_runner").with(asset.id)
        end
      end
      it "should return a runner list" do
        expect(subject.find(asset)).to be_kind_of OregonDigital::Derivatives::DelayedRunner
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
