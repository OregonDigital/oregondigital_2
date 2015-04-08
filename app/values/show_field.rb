class ShowField
  attr_reader :property
  def initialize(property)
    @property = property.to_s
  end

  def key
    "#{property}_ssm"
  end

  def label
    property.humanize
  end
end
