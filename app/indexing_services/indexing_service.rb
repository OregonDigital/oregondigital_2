class IndexingService < ActiveFedora::IndexingService
  # Override rdf_service to allow indexing AF::Base objects.
  def rdf_service
    IdentifiableIndexing
  end

  def generate_solr_document
    super.tap do |solr_doc|
      solr_doc.merge!('public_bsi' => object.public?)
      solr_doc.merge!('reviewed_bsi' => object.reviewed?)
    end
  end
end
