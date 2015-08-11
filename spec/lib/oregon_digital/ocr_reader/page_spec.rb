require 'rails_helper'

RSpec.describe OregonDigital::OCRReader::Page do
  let(:reader) { OregonDigital::OCRReader::Reader.new(ocr_content) }
  let(:ocr_content) { File.open(file_path).read }
  let(:file_path) { Rails.root.join("spec", "fixtures", "ocr_text.html") }
 
  describe "#stringified_words" do
    it "should return an array of stringified words on that page" do
      expect(reader.pages.first.stringified_words).to eq ["The"]
    end
  end

  describe "#words" do
    it "should return an array of words on that page" do
      expect(reader.pages.first.words.length).to eq 1
      expect(reader.pages.first.words.first).to be_a(OregonDigital::OCRReader::Word)
    end
  end

  describe "#page_number" do
    it "should return the number associated with that page" do
      expect(reader.pages.first.page_number).to eq 1
    end
  end

end
