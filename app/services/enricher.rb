class Enricher
  pattr_initialize(:id)

  def enrich!
    connection.update(
      :params => { softCommit: true },
      :data => [enriched_solr_document].to_json,
      :headers => { 'Content-Type' => 'application/json' }
    ) unless enriched_solr_document.empty?
  end

  private

  def enriched_solr_document
    @enriched_solr_document ||= EnrichedSolrDocument.new(solr_document).to_solr
  end

  def solr_document
    @solr_document ||= solr_service.query("id:#{RSolr.solr_escape(id)}").first
  end

  def connection
    @connection ||= ActiveFedora.solr.conn
  end

  def solr_service
    @solr_service ||= ActiveFedora::SolrService
  end
end
