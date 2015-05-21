class ShowField
  attr_reader :property
  def initialize(property)
    @property = property.to_s
  end

  def key
    solr_name_generator.solr_name(property, :symbol)
  end

  def label
    property.humanize
  end

  private

  def solr_name_generator
    ActiveFedora::SolrQueryBuilder
  end
end
