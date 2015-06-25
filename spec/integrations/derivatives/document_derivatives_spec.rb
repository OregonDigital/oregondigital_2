
require 'rails_helper'

RSpec.describe "document derivatives", :perform_enqueued => true do
  it "should work" do
    document = Document.new
    file = File.open(File.join(fixture_path, "tiny_pdf.pdf"))
    document.content.content = file
    document.content.mime_type = "application/pdf"
    asset_with_derivatives = AssetWithDerivativesFactory.new(document)

    expect{asset_with_derivatives.save}.not_to raise_error
    reloaded_document = Document.find(document.id)
    expect(reloaded_document.workflow_metadata.pdf_pages_path).not_to be_blank
    expect(reloaded_document.workflow_metadata.pdf_pages_path).to include document.id
    expect(reloaded_document.workflow_metadata.ocr_path).to include "ocr.html"
    expect(reloaded_document.workflow_metadata.thumbnail_path).to include document.id
  end
end
