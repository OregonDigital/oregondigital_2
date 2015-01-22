require 'rspec/expectations'

RSpec::Matchers.define :have_derivative_accessors_for do |accessor, attributes|
  match do |object|
    attributes ||= [true, true]
    has_accessors?(object, method_getter(accessor), method_setter(accessor), attributes.first) &&
      has_accessors?(object, path_getter(accessor), path_setter(accessor), attributes.last)
  end
  failure_message do |object|
    return no_has_matchers_message(object, accessor) unless has_accessors?(object, method_getter(accessor), method_setter(accessor), attributes.first)
    return no_path_accessors_message(object, accessor) unless has_accessors?(object, path_getter(accessor), path_setter(accessor), attributes.last)
    "something is wrong with #{object}"
  end

  def has_accessors?(object, getter, setter, attribute)
    return false unless object.respond_to?(getter) && object.respond_to?(setter)
    delegates_accessors?(object, getter, setter, attribute)
  end

  def delegates_accessors?(object, getter, setter, attribute)
    return false unless object.respond_to?(:workflow_metadata)
    object.__send__(setter, attribute)
    return false unless object.workflow_metadata.__send__(getter) == attribute
    return false unless object.__send__(getter) == attribute
    true
  end

  def no_has_matchers_message(object, accessor)
    "Expected #{object} to have delegated accessors to workflow_metadata for #{method_getter(accessor)} and #{method_setter(accessor)} but it didn't."
  end

  def no_path_accessors_message(object, accessor)
    "Expected #{object} to have delegated accessors to workflow_metadata for #{path_getter(accessor)} and #{path_setter(accessor)} but it didn't."
  end

  def method_getter(accessor)
    :"has_#{accessor}"
  end

  def method_setter(accessor)
    :"#{method_getter(accessor)}="
  end

  def path_getter(accessor)
    :"#{accessor}_path"
  end

  def path_setter(accessor)
    :"#{path_getter(accessor)}="
  end

end
