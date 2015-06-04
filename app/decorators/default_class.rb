##
# Decorator to apply a default class to a property. If a property is already
# defined on that property it will not override it.
class DefaultClass < SimpleDelegator
  attr_reader :default_class_name
  # @param [ActiveTriples::Property] item Property to decorate
  # @param [String, Class] default_class_name Class to use as a default
  def initialize(item, default_class_name)
    @default_class_name = default_class_name
    super(item)
  end

  def class_name
    __getobj__.class_name || default_class_name
  end

  def to_h
    {:class_name => default_class_name}.merge(__getobj__.to_h)
  end
end
