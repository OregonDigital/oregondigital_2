class DefaultClass < SimpleDelegator
  attr_reader :default_class_name
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
