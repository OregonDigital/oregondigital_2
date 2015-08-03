class IndexingService < ActiveFedora::IndexingService
  # Override rdf_service to allow indexing AF::Base objects.
  def rdf_service
    IdentifiableIndexing
  end

  def generate_solr_document
    super.tap do |solr_doc|
      solr_doc.merge!('public_bsi' => decorated_object.public?)
      solr_doc.merge!('reviewed_bsi' => decorated_object.reviewed?)
    end
  end

  private

  def decorated_object
    @decorated_object ||= Reviewable.new(object)
  end
end
