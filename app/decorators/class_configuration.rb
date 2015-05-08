class ClassConfiguration < SimpleDelegator
  attr_reader :config_map
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
