class IdentifiableIndexing < ActiveFedora::RDF::IndexingService

  def solr_document_field_value(val)
    if val.kind_of?(ActiveFedora::Base)
      val = val.resource
    end
    super(val)
  end

  private

  def kind_of_af_base?(*args)
    false
  end
end
