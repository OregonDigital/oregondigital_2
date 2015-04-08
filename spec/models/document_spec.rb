require 'rails_helper'

RSpec.describe Document do
  let(:resource_class) { Document }
  subject { resource_class.new }
  describe "#derivatives" do
    it "should be set" do
      expect(subject.derivatives).to eq [:pdf_pages, :ocr, :thumbnail]
    end
    it "should have a runner for each derivative" do
      subject.derivatives.each do |derivative|
        expect(OregonDigital.derivative_injector).to respond_to :"#{derivative}_runner"
      end
    end
  end

  describe "#streamable_content" do
    let(:file) { File.open(File.join(fixture_path, 'fixture_pdf.pdf'), 'rb') }
    context "when there's content" do
      before do
        subject.content.content = file
        subject.content.mime_type = "application/pdf"
      end
      it "should be a StreamableContent" do
        result = subject.streamable_content

        expect(result).to be_a StreamableContent
        expect(result.mime_type).to eq "application/pdf"
        expect(result.content).to eq file
      end
    end
  end

  describe "#pdf_pages" do
    let(:path) { Rails.root.join("tmp", "documents").to_s }
    it "should have derivative accessors for pdf_pages" do
      expect(subject).to have_derivative_accessors_for(:pdf_pages, [true, path])
    end
  end

  describe "#ocr" do
    let(:path) { Rails.root.join("tmp", "ocr.html").to_s }
    it "should have derivative accessors for ocr" do
      expect(subject).to have_derivative_accessors_for(:ocr, [true, path])
    end
  end

end
