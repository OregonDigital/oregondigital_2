##
# Represents a solr property in a solr document. Has a property_key and values
# associated with it.
class SolrProperty
  attr_reader :property_key, :values
  def initialize(property_key, values)
    @property_key = property_key.to_s
    @values = Array.wrap(values)
  end

  def key
    split_key.first
  end

  def solr_identifier
    split_key.last
  end

  private

  def split_key
    @split_key ||= property_key.rpartition("_")
  end
end
