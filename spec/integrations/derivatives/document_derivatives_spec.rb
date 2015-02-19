
require 'rails_helper'

RSpec.describe "document derivatives" do
  it "should work" do
    Bogus.clear
    document = Document.new
    file = File.open(File.join(fixture_path, "tiny_pdf.pdf"))
    document.content.content = file
    document.content.mime_type = "application/pdf"
    runner_finder = OregonDigital::Derivatives::RunnerFinder.new(OregonDigital.derivative_injector)
    lazy_runner = OregonDigital::Derivatives::LazyRunner.new(runner_finder)
    asset_with_derivatives = AssetWithDerivatives.new(document, lazy_runner)

    expect{asset_with_derivatives.save}.not_to raise_error
    expect(document.workflow_metadata.pdf_pages_path).not_to be_blank
    expect(document.workflow_metadata.pdf_pages_path).to include document.id
    expect(document.workflow_metadata.ocr_path).to include "ocr.html"
  end
end
