module OregonDigital
  module GraphMutators
    class SubjectChanger
      class << self
        def call(graph, find_subject, replace_subject)
          new(graph).replace_subject(find_subject, replace_subject)
        end
      end
      attr_accessor :graph
      def initialize(graph)
        @graph = graph
      end

      def replace_subject(find_subject, replace_subject)
        graph.statements.each do |s|
          subject = s.subject
          subject = replace_subject if subject == find_subject
          tmp_graph << [subject, s.predicate, s.object]
        end
        tmp_graph
      end
    end

    private

    def tmp_graph
      @tmp_graph ||= RDF::Graph.new
    end
  end
end
