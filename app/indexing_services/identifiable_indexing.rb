class IdentifiableIndexing < ActiveFedora::RDF::IndexingService

  # Index a value's resource if it exists.
  def solr_document_field_value(val)
    val = MaybeIdentifiable.new(val).value
    super(val)
  end

  private

  # Don't ignore AF::Base objects.
  def kind_of_af_base?(*args)
    false
  end
end
