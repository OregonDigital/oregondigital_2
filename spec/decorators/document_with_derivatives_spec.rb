require 'rails_helper'

RSpec.describe DocumentWithDerivatives do
  verify_contract :document_with_derivatives
  subject { DocumentWithDerivatives.new(document) }
  fake(:document, :id => "1")
  fake(:asset_with_derivatives)
  fake(:injector)
  let(:pdf_runner) { injector.pdf_runner(subject.id) }
  fake(:runner_list) { OregonDigital::Derivatives::Runners::RunnerList }
  before do
    stub(document).injector { injector }
    stub(OregonDigital::Derivatives::Runners::RunnerList).new([pdf_runner]) { runner_list }
  end
  describe "derivatives" do
    context "when saved" do
      before do
        stub(AssetWithDerivatives).new(document, runner_list) { asset_with_derivatives }
        subject.save
      end
      it "should call asset_with_derivative's save method" do
        expect(asset_with_derivatives).to have_received.save
      end
    end
  end

  describe "#pdf_success" do
    let(:result) { subject.pdf_success(path) }
    let(:path) { Rails.root.join("tmp", "documents").to_s }
    before do
      result
    end
    it "should set has_pdf_pages" do
      expect(document).to have_received(:has_pdf_pages=, true)
    end
    it "should set pdf_pages_path" do
      expect(document).to have_received(:pdf_pages_path=, path)
    end
  end
end
