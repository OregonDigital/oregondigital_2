require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::ImageRunners do
  subject { OregonDigital::Derivatives::Runners::ImageRunners.new(derivative_injector) }
  let(:asset) { fake(:image, :id => "1") }
  fake(:derivative_injector)
  describe "#run" do
    before do
      subject.run(asset)
    end
    it "should call #run on a pyramidal_runner" do
      expect(derivative_injector.pyramidal_runner(asset.id)).to have_received.run(asset)
    end
    it "should call #run on a thumbnail_runner" do
      expect(derivative_injector.thumbnail_runner(asset.id)).to have_received.run(asset)
    end
    it "should call #run on a medium_runner" do
      expect(derivative_injector.medium_runner(asset.id)).to have_received.run(asset)
    end
  end
end
