require 'rails_helper'

RSpec.describe Document do
  verify_contract :document
  let(:resource_class) { Document }
  subject { resource_class.new }
  describe "contracts" do
    it "should be able to have an id" do
      expect(resource_class.new(:id => "1").id).to eq "1"
    end
  end

  describe "#pdf_pages" do
    let(:path) { Rails.root.join("tmp", "documents").to_s }
    it "should have derivative accessors for pdf_pages" do
      expect(subject).to have_derivative_accessors_for(:pdf_pages, [true, path])
    end
  end

  describe "derivatives" do
    fake(:document_generator) { OregonDigital::Derivatives::Generators::DocumentDerivativeGenerator}
    fake(:injector)
    let(:pdf_runner) { injector.pdf_runner(subject.id) }
    before do
      stub(OregonDigital::Derivatives::Generators::DocumentDerivativeGenerator).new(subject, subject.content, pdf_runner) { document_generator }
    end
    let(:assign_content) {}
    context "when saved" do
      let(:file) { File.open(File.join(fixture_path, 'fixture_image.jpg'), 'rb') }
      before do
        assign_content
        subject.save
      end
      context "when there's new content" do
        let(:assign_content) do
          subject.content.content = file
        end
        it "should try to run derivatives" do
          expect(document_generator).to have_received.run
        end
      end
    end
  end
end
