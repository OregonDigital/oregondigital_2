module OregonDigital
  module GraphMutators
    class PredicatePruner
      class << self
        def call(graph, regex)
          new(graph, regex).run
        end
      end

      attr_accessor :graph, :regex
      def initialize(graph, regex)
        @graph = graph
        @regex = regex
      end

      def run
        graph.each_statement do |s|
          next if s.predicate.to_s =~ regex
          tmp_graph << s
        end
        tmp_graph
      end

      private

      def tmp_graph
        @tmp_graph ||= RDF::Graph.new
      end
    end
  end
end
