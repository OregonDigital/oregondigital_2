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

  [:pdf_pages].each do |derivative|
    describe "#has_#{derivative}" do
      before do
        subject.__send__(:"has_#{derivative}=", true)
      end
      it "should set it on workflow metadata" do
        expect(subject.workflow_metadata.send(:"has_#{derivative}")).to eq true
        expect(subject.send(:"has_#{derivative}")).to eq true
      end
    end
    describe "#{derivative}_path=" do
      let(:path) { Rails.root.join("tmp", "documents").to_s }
      before do
        subject.__send__(:"#{derivative}_path=", path)
      end
      it "should set it on workflow metadata" do
        expect(subject.workflow_metadata.send(:"#{derivative}_path")).to eq path
        expect(subject.send(:"#{derivative}_path")).to eq path
      end
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
