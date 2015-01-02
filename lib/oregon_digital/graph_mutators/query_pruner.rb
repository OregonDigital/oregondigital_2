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
    end

    def run
      subject_regex, predicate_regex, object_regex = extract_regex
      skip_statements = []
      graph.query(query).each do |statement|
        unless (statement.subject.to_s =~ subject_regex || statement.predicate.to_s =~ predicate_regex || statement.object.to_s =~ object_regex)
          tmp_graph << statement
        end
        skip_statements << statement
      end
      graph.each_statement do |statement|
        tmp_graph << statement unless skip_statements.include?(statement)
      end
      tmp_graph
    end

    private

    def tmp_graph
      @tmp_graph ||= RDF::Graph.new
    end

    def extract_regex
      regex = []
      query.each_with_index do |item, i|
        regex[i] = item if item.kind_of? Regexp
        query[i] = nil if regex[i]
      end
      return regex
    end
  end
  end
end
