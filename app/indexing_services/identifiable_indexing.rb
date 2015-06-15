class IdentifiableIndexing < ActiveFedora::RDF::IndexingService

  def solr_document_field_value(val)
    val = MaybeIdentifiable.new(val).value
    super(val)
  end

  private

  def kind_of_af_base?(*args)
    false
  end
end
