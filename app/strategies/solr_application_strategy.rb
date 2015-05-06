class SolrApplicationStrategy
  def call(object, property)
    property = Property.new(*property)
    object.property property.name, property.to_h do |index|
      index.as(*index_types)
    end
  end

  private

  def index_types
    [:searchable, :displayable, :facetable]
  end
end

class Property
  vattr_initialize :name, :config

  delegate :predicate, :class_name, :to => :config

  def to_h
    {
      :predicate => predicate,
      :class_name => class_name
    }
  end
end
