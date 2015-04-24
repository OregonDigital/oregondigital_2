require 'rails_helper'

RSpec.describe TriplePoweredResource do
  subject { TriplePoweredResource.new(subject_uri) }
  let(:subject_uri) { RDF::URI("http://id.loc.gov/authorities/names/n80017721") }
  before { ActiveFedora::Cleaner.clean! }
  
  context "when new" do
    it "should have no statements" do
      expect(subject.statements.to_a.length).to eq 0
    end
  end
  it "should be able to handle not having a URI passed" do
    expect{described_class.new}.not_to raise_error
  end
  context "when persisted with statements" do
    before do
      subject << [subject.rdf_subject, RDF::DC.title, "Test"]
      subject.persist!
    end
    it "should be able to be reloaded and maintain those statements" do
      reloaded_resource = TriplePoweredResource.new(subject_uri)
      expect(reloaded_resource.query([nil, RDF::DC.title, nil]).statements.to_a.length).to eq 1
      expect(reloaded_resource.statements.to_a.length).to eq 24
      expect(reloaded_resource.statements.to_a.first.subject).to eq subject.rdf_subject
    end
  end
end
