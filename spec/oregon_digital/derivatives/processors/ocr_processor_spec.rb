require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Processors::OcrProcessor do
  let(:processor) { described_class.new(File.new(file), {:path => path}) }
  let(:path) { Rails.root.join("spec", "fixtures") }
  let(:file) {Rails.root.join("spec", "fixtures", "test_file.txt")}

  describe "#run" do
    context "When an improper path is used" do
      it "should raise an error" do
        expect(processor.error_message("error")).to eq("Error raised by pdftotext: error")
      end
    end
  end
end
