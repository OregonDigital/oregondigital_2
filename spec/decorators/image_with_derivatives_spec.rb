require 'rails_helper'

RSpec.describe ImageWithDerivatives do
  subject { ImageWithDerivatives.new(image) }
  fake(:image, :id => "1")
  fake(:asset_with_derivatives)
  fake(:injector)
  let(:thumbnail_runner) { injector.thumbnail_runner(subject.id)}
  let(:medium_runner) { injector.medium_runner(subject.id) }
  let(:pyramidal_runner) { injector.pyramidal_runner(subject.id) }
  before do
    stub(image).injector { injector }
  end
  describe "derivatives" do
    context "when saved" do
      before do
        stub(AssetWithDerivatives).new(image, OregonDigital::Derivatives::Generators::ImageDerivativeGenerator, [thumbnail_runner, medium_runner, pyramidal_runner]) { asset_with_derivatives }
        subject.save
      end
      it "should call asset_with_derivative's save method" do
        expect(asset_with_derivatives).to have_received.save
      end
    end
  end
end
