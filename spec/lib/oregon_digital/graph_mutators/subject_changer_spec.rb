require 'rails_helper'

RSpec.describe OregonDigital::GraphMutators::SubjectChanger do
  subject { described_class.new(graph) }
  let(:graph) do
    r = RDF::Graph.new
    r << RDF::Statement.new(find_subject, RDF::DC.title, "bla")
    r << RDF::Statement.new(ignore_subject, RDF::DC.title, "bla")
    r
  end
  let(:find_subject) { RDF::URI.new("http://bla.org") }
  let(:replace_subject) { RDF::URI.new("http://test.org") }
  let(:ignore_subject) { RDF::URI("http://bla.org/bla/bla2") }
  describe "#replace_subject!" do
    let(:result) { subject.replace_subject(find_subject, replace_subject) }
    let(:subjects) { result.each_subject.to_a }
    it "returns an RDF::Graph" do
      expect(result).to be_kind_of RDF::Graph
    end
    it "mutates the subjects" do
      expect(subjects.first).to eq replace_subject
      expect(subjects.last).to eq ignore_subject
    end
    context "when given a blank graph" do
      let(:graph) { RDF::Graph.new }
      it "should just return it" do
        expect(result).to eq graph
      end
    end
  end
end
