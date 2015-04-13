require 'rails_helper'

RSpec.describe LcshValidator do
  subject { LcshValidator.new }
  describe "#valid?" do
    let(:result) { subject.valid?(value) }
    context 'when given a non-lcsh uri' do
      let(:value) { [RDF::URI("http://opaquenamespace.org/ns/subject/bad")] }
      it "should return false" do
        expect(result).to eq false
      end
    end
    context "when given an lcsh uri" do
      let(:value) { [RDF::URI("http://id.loc.gov/authorities/subjects/1")] }
      it "should return true" do
        expect(result).to eq true
      end
    end
    context "when given a string and not a URI" do
      let(:value) { ["http://id.loc.gov/authorities/subjects/1"] }
      it "should return false" do
        expect(result).to eq false
      end
    end
  end

  describe "#message" do
    it "should be right" do
      expect(subject.message).to eq "contains a non-LCSH term"
    end
  end
end
