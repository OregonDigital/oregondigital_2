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

  def grouped_facets
    @grouped_facets ||= all_facet_fields.group_by(&:key).symbolize_keys
  end

  def facet_keys
    @facet_keys ||= all_facet_fields.map(&:key).map(&:to_sym)
  end

  def all_solr_fields
    @all_solr_fields ||= SolrFieldSummary.where(:field => "*")
  end

  def solr_field_iterator
    @solr_field_iterator ||= iterator_factory.new(all_solr_fields).map do |k, v|

      setup_facet_item_set(v) if k == :set

      [k, HasFacetField.new(v, grouped_facets[k].try(:first) || FacetField.new(:key => k))]
    end
  end

  def setup_facet_item_set(value)
    top_terms = value.topTerms.each_slice(2).to_a
    top_terms.each { |item| facet_item item }
  end

  def facet_item(item)
    FacetItem.where(:value => item.first).first_or_create
  end

  def iterator_factory
    FacetableSolrFieldIterator
  end
end
