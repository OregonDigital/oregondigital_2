require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::PdfRunner do
  verify_contract :pdf_runner
  let(:resource_class) { OregonDigital::Derivatives::Runners::PdfRunner }
  let(:path) { Rails.root.join("tmp", "documents").to_s }
  let(:resource) { resource_class.new(path) }
  let(:file) { fake(:file) { File } }
  let(:callback) { fake(:document_generator) { OregonDigital::Derivatives::Generators::DocumentDerivativeGenerator } }
  subject { resource }
  describe "#run" do
    let(:result) { subject.run(file, callback) }
    fake(:pdf_processor) { OregonDigital::Derivatives::Processors::PdfProcessor }
    let(:options) do
      {
        :path => path
      }
    end
    before do
      stub(OregonDigital::Derivatives::Processors::PdfProcessor).new(file, options) { pdf_processor }
      result
    end

    it "should call #pdf_success on the callback" do
      expect(callback).to have_received.pdf_success(path)
    end
    it "should call pdf processor" do
      expect(pdf_processor).to have_received.run
    end
  end
end
