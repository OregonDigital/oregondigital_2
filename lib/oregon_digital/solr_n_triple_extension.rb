module OregonDigital
  module SolrNTripleExtension
    def self.extended(document)
      document.will_export_as(:nt, "text/n3")
    end
    def export_as_nt
      object = ActiveFedora::Base.find(self["id"])
      graph = object.resource
      [RDF::LDP.to_iri, ActiveFedora::RDF::Fcrepo4.to_iri, "http://www.jcp.org/jcr/"].each do |bad_type|
        graph = OregonDigital::GraphMutators::QueryPruner.call(graph, [nil, RDF.type, /^#{bad_type}/])
      end
      [ActiveFedora::RDF::Fcrepo4.to_iri, "info:fedora/"].each do |bad_predicate|
        graph = OregonDigital::GraphMutators::PredicatePruner.call(graph, /^#{bad_predicate}/)
      end
      graph = OregonDigital::GraphMutators::SubjectChanger.call(graph, object.resource.rdf_subject, RDF::URI("http://oregondigital.org/resource/#{object.id}"))
      graph.dump(:ntriples)
    end
  end
end
