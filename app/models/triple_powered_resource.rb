class TriplePoweredResource < ActiveTriples::Resource
  def repository
    @repository ||= FedoraLDPRepository.new(rdf_subject)
  end
end
