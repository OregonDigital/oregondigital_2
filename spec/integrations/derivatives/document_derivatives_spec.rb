
require 'rails_helper'

RSpec.describe "image derivatives" do
  subject { AssetWithDerivatives.new(document) }
  let(:document) { Document.new }
  let(:file) { File.open(File.join(fixture_path, "fixture_pdf.pdf")) }
  before do
    Bogus.clear
    document.content.content = file
    document.content.mime_type = "application/pdf"
  end
  it "should work" do
    expect{subject.save}.not_to raise_error
    expect(document.workflow_metadata.pdf_pages_path).not_to be_blank
  end
end
