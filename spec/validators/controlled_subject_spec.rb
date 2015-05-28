require 'rails_helper'

RSpec.describe ControlledSubject do
  subject { described_class.new }

  describe "#valid?" do
    let(:result) { subject.valid_value?(value) }
    context "when given a string" do
      let(:value) { "string" }
      it "should not be valid" do
        expect(result).to eq false
      end
    end
    context "when given an OpaqueNamespace URI" do
      let(:value) { RDF::URI("http://opaquenamespace.org/ns/subject/1") }
      it "should be valid" do
        expect(result).to eq true
      end
    end
    context "when given an LCSH URI" do
      let(:value) { RDF::URI("http://id.loc.gov/authorities/subjects/1") }
      it "should be valid" do
        expect(result).to eq true
      end
    end
    context "when given a Getty URI" do
      let(:value) { RDF::URI("http://vocab.getty.edu/tgn/1") }
      it "should be valid" do
        expect(result).to eq true
      end
    end
  end
end
