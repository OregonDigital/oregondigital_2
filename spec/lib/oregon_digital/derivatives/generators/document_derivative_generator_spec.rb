require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Generators::DocumentDerivativeGenerator do
  verify_contract :document_generator
  let(:resource_class) { OregonDigital::Derivatives::Generators::DocumentDerivativeGenerator }
  let(:resource) { resource_class.new(document, file_io, pdf_runner) }
  subject { resource }
  fake(:document, :id => "1")
  fake(:file_io) { FileContent }
  fake(:pdf_runner) { OregonDigital::Derivatives::Runners::PdfRunner }

  let(:real_file_content) { File.open(File.join(fixture_path, 'fixture_pdf.pdf'), 'rb').read }
  let(:path) { Rails.root.join("tmp", "documents").to_s }
  before do
    stub(file_io).content { real_file_content }
    make_equal_to_fakes(subject.stream_content)
    make_equal_to_fakes(subject)
  end

  describe "#run" do
    let(:result) { resource.run }
    before do
      result
    end
    it "should generate pdf derivatives" do
      expect(pdf_runner).to have_received.run(subject.stream_content, subject)
    end
  end

  describe "#pdf_success" do
    let(:result) { subject.pdf_success(path) }
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
