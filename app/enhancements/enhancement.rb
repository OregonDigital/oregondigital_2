##
# Enhancements take a SolrProperty and return another SolrProperty with new
# values.
class Enhancement
  attr_reader :raw_property

  # @param [SolrProperty] raw_property The property to transform
  def initialize(raw_property)
    @raw_property = raw_property
  end

  # @return [SolrProperty] The transformed property.
  def property
    raise NotImplementedError
  end

end
