require 'rails_helper'

RSpec.describe DocumentWithDerivatives do
  subject { DocumentWithDerivatives.new(document) }
  fake(:document, :id => "1")
  fake(:asset_with_derivatives)
  fake(:injector)
  let(:pdf_runner) { injector.pdf_runner(subject.id) }
  before do
    stub(document).injector { injector }
  end
  describe "derivatives" do
    context "when saved" do
      before do
        stub(AssetWithDerivatives).new(document, OregonDigital::Derivatives::Generators::DocumentDerivativeGenerator, [pdf_runner]) { asset_with_derivatives }
        subject.save
      end
      it "should call asset_with_derivative's save method" do
        expect(asset_with_derivatives).to have_received.save
      end
    end
  end
end
