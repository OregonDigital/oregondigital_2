
require 'rails_helper'

RSpec.describe "image derivatives" do
  it "should work" do
    Bogus.clear
    document = Document.new
    file = File.open(File.join(fixture_path, "fixture_pdf.pdf"))
    document.content.content = file
    document.content.mime_type = "application/pdf"
    asset_with_derivatives = DerivativeCreationFacade.call(document, OregonDigital.derivative_injector)

    expect{asset_with_derivatives.save}.not_to raise_error
    expect(document.workflow_metadata.pdf_pages_path).not_to be_blank
  end
end
