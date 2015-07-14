class LDPathEnhancement
  pattr_initialize :raw_property, :ldpath_configuration
  delegate :path, :to => :ldpath_configuration

  def properties
    [SolrProperty.new(solr_identifier, values)]
  end

  private

  def solr_identifier
    derivative_property.property_key
  end

  def derivative_property
    raw_property.derivative_key(ldpath_configuration.name)
  end

  def values
    uris.flat_map do |uri|
      connection.ldpath(uri).get(path)
    end.map {|x| x["value"]}
  end

  def connection
    OregonDigital.marmotta
  end

  def uris
    OnlyUris.new(raw_property.values)
  end
end
