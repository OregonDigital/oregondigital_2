require 'spec_helper'
require 'oregon_digital/graph_mutators/predicate_pruner'
require 'linkeddata'

RSpec.describe OregonDigital::GraphMutators::PredicatePruner do
  describe "#call" do
    let(:graph) { RDF::Graph.new }
    let(:graph) do
      g = RDF::Graph.new
      g << RDF::Statement.new(RDF::URI("http://bla.bla.org/bla"), RDF.type, "type")
      g << RDF::Statement.new(RDF::URI("http://bla.bla.org/bla"), RDF::DC.title, "title")
      g
    end
    let(:regex) { /^#{RDF.type}/ }
    let(:result) { described_class.call(graph, regex) }
    context "when given a graph and a regex" do
      context "which matches" do
        it "should return a graph without the matching predicates" do
          expect(result.statements.to_a.length).to eq 1
          expect(result.statements.to_a.first.predicate).to eq RDF::DC.title
        end
      end
    end
  end

end
