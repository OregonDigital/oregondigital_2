class EnrichDocumentJob < ActiveJob::Base
  queue_as :low

  def perform(solr_id)
    Enricher.new(solr_id).enrich!
  end
end
