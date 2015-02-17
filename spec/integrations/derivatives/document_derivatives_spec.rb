
require 'rails_helper'

RSpec.describe "image derivatives" do
  subject { AssetWithDerivatives.new(document, runners, derivative_callback, stream_content) }
  let(:document) { Document.new }
  let(:derivative_callback) { OregonDigital::Derivatives::DerivativeCallback.new(document) }
  let(:stream_content) { StreamableContent.new(document.content.content, document.content.mime_type) }
  let(:runners) { OregonDigital::Derivatives::Runners::RunnerFinder.find(document) }
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
