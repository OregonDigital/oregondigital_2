class HasFacetField < SimpleDelegator
  attr_reader :facet
  def initialize(object, facet_field)
    @facet = facet_field
    super(object)
  end
end
