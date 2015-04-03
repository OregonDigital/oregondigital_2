module OregonDigital
  module RdfConnegExtension
    def self.extended(document)
      document.will_export_as(:nt, "application/n-triples")
      document.will_export_as(:ttl, "text/turtle")
      document.will_export_as(:jsonld, "application/json")
    end

    def clean_graph
      @clean_graph ||= CleanRepository.new(ActiveFedora.fedora.clean_connection, GenericAsset).find(id)
    end

    def export_as_nt
      clean_graph.dump(:ntriples)
    end

    def export_as_ttl
      clean_graph.dump(:ttl)
    end

    def export_as_jsonld
      clean_graph.dump(:jsonld, :standard_prefixes => true)
    end
  end
end
