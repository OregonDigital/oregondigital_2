class IndexingService < ActiveFedora::IndexingService
  def rdf_service
    IdentifiableIndexing
  end
end
