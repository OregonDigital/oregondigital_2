# Decorator for OregonDigital::Fields::InputFactory to allow the URI-enabled
# input type
class HasURIInputType < SimpleDelegator
  def options
    opts = super.dup
    opts[:input_html] ||= {}
    opts[:input_html][:type] = "uri_enabled_string"
    opts
  end
end
