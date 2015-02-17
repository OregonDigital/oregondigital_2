require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Processors::OcrProcessor do
  verify_contract :ocr_processor


  subject { OregonDigital::Derivatives::Processors::OcrProcessor.new(file, options) }
  let(:file) { File.open(File.join(fixture_path, "tiny_pdf.pdf")) }
  let(:options) do
    {
      :path => path
    }
  end
  let(:path) { Rails.root.join("tmp", "documents", "ocr.html").to_s }
  let(:pathname) { Pathname.new(path) }

  describe "#run" do
    before do
      subject.run
    end
    after do
      FileUtils.rm_rf(pathname.dirname) if File.exists?(path)
    end
    it "should create an OCR document" do
      expect(File.exists?(path)).to eq true
      expect(File.open(path).read).not_to be_blank
    end
  end
end
