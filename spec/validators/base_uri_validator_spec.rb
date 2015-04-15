require 'rails_helper'

RSpec.describe BaseUriValidator do
  subject { BaseUriValidator.new("http://opaquenamespace.org/ns/subject") }
  describe "#valid?" do
    let(:result) { subject.valid?(value) }
    context 'when given a bad uri' do
      let(:value) { [RDF::URI("http://bla.org/bla")] }
      it "should return false" do
        expect(result).to eq false
      end
    end
    context "when given an good uri" do
      let(:value) { [RDF::URI("http://opaquenamespace.org/ns/subject/1")] }
      it "should return true" do
        expect(result).to eq true
      end
    end
    context "when given a string and not a URI" do
      let(:value) { ["http://opaquenamespace.org/ns/subject/1"] }
      it "should return false" do
        expect(result).to eq false
      end
    end
  end

  describe "#message" do
    it "should be right" do
      expect(subject.message).to eq "is not in the base uri http://opaquenamespace.org/ns/subject"
    end
  end
end
