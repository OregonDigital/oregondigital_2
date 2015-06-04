##
# An application strategy to also apply solr indexes for each property.
# @note If how a field is indexed changes based on property, this would be a
#   good place to define that.
class SolrApplicationStrategy
  # @param [ActiveFedora::Base] object The object to apply the property to.
  # @param [ActiveTriples::Property, #name, #to_h] property The property to define.
  def call(object, property)
    object.property property.name, property.to_h do |index|
      index.as(*index_types)
    end
  end

  private

  def index_types
    [:stored_searchable, :symbol]
  end
end
