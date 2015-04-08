require 'rails_helper'
require 'oregon_digital/derivatives/processors/image_processor'

RSpec.describe OregonDigital::Derivatives::Processors::PdfProcessor do
  subject { OregonDigital::Derivatives::Processors::PdfProcessor.new(file, options) }
  let(:file) { File.open(File.join(fixture_path, "tiny_pdf.pdf")) }
  let(:options) do
    {
      :path => path,
      :sizes => sizes
    }
  end
  let(:sizes) do
    {
      "x-large" => "2x",
      "large" => "1x"
    }
  end
  let(:path) { Rails.root.join("tmp", "documents").to_s }
  let(:pathname) { Pathname.new(path) }

  describe "#run" do
    let(:result) { subject.run }
    before do
      result
    end
    after do
      FileUtils.rm_rf(path) if File.exists?(path)
    end
    def pages
      Dir[Pathname.new(path).join("*")]
    end
    let(:expected_result) do
      arr = []
      ["large", "x-large"].each do |size|
        (1..1).each do |page|
          arr << pathname.join("#{size}-page-#{page}.jpg").to_s
        end
      end
      arr
    end
    it "should create page*quality pages" do
      expect(File.exists?(path)).to eq true
      expect(pages.length).to eq 2
      expect(pages).to eq expected_result
    end
  end
end
