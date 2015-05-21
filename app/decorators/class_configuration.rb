##
# Decorator to add class configurations to each property given a map of
# properties to class names.
# @note If a property is configured here it will override previously defined
#   classes on that property.
class ClassConfiguration < SimpleDelegator
  attr_reader :config_map
  # @param [Property] item Property to decorate.
  # @param [Hash{Symbol => String, Class}] Hash of properties to the class to
  #   map them to.
  def initialize(item, config_map)
    @config_map = config_map
    super(item)
  end

  def class_name
    config_map[name.to_sym] || __getobj__.class_name
  end

  def to_h
    (__getobj__.to_h).merge({:class_name => class_name})
  end
end
