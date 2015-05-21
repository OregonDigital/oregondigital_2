class SolrApplicationStrategy
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

