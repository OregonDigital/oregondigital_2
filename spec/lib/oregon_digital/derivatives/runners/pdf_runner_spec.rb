require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::PdfRunner do
  let(:resource_class) { OregonDigital::Derivatives::Runners::PdfRunner }
  subject { resource_class.new(path, callback_factory) }

  let(:path) { Rails.root.join("tmp", "documents").to_s }
  let(:callback_factory) { double("callback factory") }
  let(:derivative_callback) { instance_double(OregonDigital::Derivatives::DerivativeCallback) }

  describe "#run" do
    let(:asset) { object_double(Document.new, :streamable_content => file) }
    let(:file) { instance_double(File) }
    let(:pdf_processor) { instance_double(OregonDigital::Derivatives::Processors::PdfProcessor) }

    before do
      allow(callback_factory).to receive(:new).with(asset).and_return(derivative_callback)
      allow(derivative_callback).to receive(:success)
      allow(pdf_processor).to receive(:run)
      allow(OregonDigital::Derivatives::Processors::PdfProcessor).to receive(:new).with(file, anything).and_return(pdf_processor)
      subject.run(asset)
    end

    it "should call #pdf_success on the callback" do
      expect(derivative_callback).to have_received(:success).with(:pdf_pages, path)
    end
    it "should call pdf processor" do
      expect(pdf_processor).to have_received(:run)
    end
  end
end
