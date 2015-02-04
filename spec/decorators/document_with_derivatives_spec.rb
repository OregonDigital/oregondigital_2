require 'rails_helper'

RSpec.describe DocumentWithDerivatives do
  subject { DocumentWithDerivatives.new(document) }
  let(:document) { Document.new }
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
