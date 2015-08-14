require 'rails_helper'

RSpec.describe OregonDigital::OCRReader::Reader do
  let(:reader) { OregonDigital::OCRReader::Reader.new(ocr_content) }
  let(:ocr_content) { File.open(file_path).read }
  let(:file_path) { Rails.root.join("spec", "fixtures", "ocr_text.html") }

  describe "#words" do
    it "should return a list of words in the entire document" do
      expect(reader.words.length).to eq 2 
      expect(reader.words.first).to be_a(OregonDigital::OCRReader::Word)
    end
  end

  describe "#pages" do
    it "should return a list of pagess in the entire document" do
      expect(reader.pages.length).to eq 2 
      expect(reader.pages.first).to be_a(OregonDigital::OCRReader::Page)
    end
  end

  describe "#stringified_words" do
    it "should return a list of words in the entire document" do
      expect(reader.stringified_words).to eq ["The", "Introduction"]
    end
  end
 
end
