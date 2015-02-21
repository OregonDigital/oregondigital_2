module OregonDigital
  module GraphMutators
    class QueryPruner
      class << self
        def call(graph, query)
          new(graph, query).run
        end
      end

      attr_accessor :graph, :query
      def initialize(graph, query)
        @graph = graph
        @query = query
        @statement_query = statement_query
      end

      def run
        graph.each_statement do |statement|
          tmp_graph << statement unless matching_statements.include?(statement)
        end
        tmp_graph
      end

      private

      class StatementQuery < Struct.new(:subject_regex, :predicate_regex, :object_regex)
        def matches_statement?(statement)
          result = statement.subject.to_s =~ subject_regex ||
            statement.predicate.to_s =~ predicate_regex ||
            statement.object.to_s =~ object_regex
          !!result
        end
      end

      def tmp_graph
        @tmp_graph ||= RDF::Graph.new
      end

      def matching_statements
        @matching_statements ||= queried_statements.select do |statement|
          statement_query.matches_statement?(statement)
        end
      end

      def queried_statements
        graph.query(query).statements.to_a
      end

      def statement_query
        return @statement_query if @statement_query
        regex = []
        query.each_with_index do |item, i|
          regex[i] = item if item.kind_of? Regexp
          query[i] = nil if regex[i]
        end
        StatementQuery.new(*regex)
      end
    end
  end
end
