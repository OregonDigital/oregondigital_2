require 'rails_helper'

RSpec.describe OregonDigital::OCRReader::Word do
  let(:reader) { OregonDigital::OCRReader::Reader.new(ocr_content) }
  let(:ocr_content) { File.open(file_path).read }
  let(:file_path) { Rails.root.join("spec", "fixtures", "ocr_text.html") }

  describe "#to_s" do
    it "should return the word in string format" do
      expect(reader.pages.first.words.first.to_s).to eq "The"
    end
  end
end
