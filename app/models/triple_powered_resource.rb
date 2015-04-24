class TriplePoweredResource < ActiveTriples::Resource
  property :preflabel, :predicate => RDF::SKOS.prefLabel
  def repository
    @repository ||= FedoraLDPRepository.new(rdf_subject)
  end
end
