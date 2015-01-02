require 'spec_helper'
require 'oregon_digital/graph_mutators/query_pruner'
require 'linkeddata'

RSpec.describe OregonDigital::GraphMutators::QueryPruner do
  describe "#call" do
    let(:graph) { RDF::Graph.new }
    let(:graph) do
      g = RDF::Graph.new
      g << RDF::Statement.new(RDF::URI("http://bla.bla.org/bla"), RDF.type, "type")
      g << RDF::Statement.new(RDF::URI("http://test.test.org/bla"), RDF::DC.type, "yo")
      g
    end
    let(:regex) { /^type/ }
    let(:query) { [nil, RDF.type, regex] }
    let(:result) { described_class.call(graph, query) }
    context "when given a graph and a query" do
      context "with regex" do
        it "should return a graph that prunes what matches the query AND regex" do
          expect(result.statements.to_a.length).to eq 1
          expect(result.statements.to_a.first.object).to eq "yo"
        end
      end
    end
  end

end
