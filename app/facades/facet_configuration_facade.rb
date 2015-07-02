class FacetConfigurationFacade
  def active
    solr_field_iterator.to_h.slice(*facet_keys)
  end

  def inactive
    solr_field_iterator.to_h.except(*facet_keys)
  end

  private

  def all_facet_fields
    @all_facet_fields ||= FacetField.all
  end

  def facet_keys
    @facet_keys ||= all_facet_fields.map(&:key).map(&:to_sym)
  end

  def all_solr_fields
    @all_solr_fields ||= SolrFieldSummary.where(:field => "*")
  end

  def solr_field_iterator
    @solr_field_iterator ||= iterator_factory.new(all_solr_fields)
  end

  def iterator_factory
    FacetableSolrFieldIterator
  end
end
