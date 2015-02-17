require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::PdfRunner do
  verify_contract :pdf_runner
  let(:resource_class) { OregonDigital::Derivatives::Runners::PdfRunner }
  subject { resource_class.new(path, callback_factory) }

  let(:path) { Rails.root.join("tmp", "documents").to_s }
  fake(:derivative_callback)
  let(:callback_factory) { fake() }

  describe "#run" do
    let(:asset) { fake(:document, :streamable_content => file) }
    let(:file) { fake(:file) { File } }
    fake(:pdf_processor) { OregonDigital::Derivatives::Processors::PdfProcessor }

    before do
      stub(callback_factory).new(asset) { derivative_callback }
      stub(OregonDigital::Derivatives::Processors::PdfProcessor).new(file, anything) { pdf_processor }
      subject.run(asset)
    end

    it "should call #pdf_success on the callback" do
      expect(derivative_callback).to have_received.pdf_success(path)
    end
    it "should call pdf processor" do
      expect(pdf_processor).to have_received.run
    end
  end
end
