require 'rails_helper'

RSpec.describe Document do
  verify_contract :document
  let(:resource_class) { Document }
  subject { resource_class.new }
  describe "contracts" do
    it "should be able to have an id" do
      expect(resource_class.new(:id => "1").id).to eq "1"
    end
    describe "#injector" do
      fake(:injector)
      before do
        make_equal_to_fakes(subject.injector)
      end
      it "should use OregonDigital's injector" do
        expect(subject.injector).to eq OregonDigital.inject
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
        make_equal_to_fakes(subject.streamable_content)
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

end
