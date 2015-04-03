module OregonDigital
  module SolrNTripleExtension
    def self.extended(document)
      document.will_export_as(:nt, "application/n-triples")
    end
    def export_as_nt
      graph = CleanRepository.new(ActiveFedora.fedora.connection, GenericAsset).find(self["id"])
      graph = OregonDigital::GraphMutators::SubjectChanger.call(graph, GenericAsset.id_to_uri(self["id"]), RDF::URI("http://oregondigital.org/resource/#{self["id"]}"))
      graph.dump(:ntriples)
    end
  end
end
