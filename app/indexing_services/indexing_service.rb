class IndexingService < ActiveFedora::IndexingService
  # Override rdf_service to allow indexing AF::Base objects.
  def rdf_service
    IdentifiableIndexing
  end
end
