# Decorator for OregonDigital::Fields::InputFactory to allow the URI-enabled
# input type
class HasURIInputType < SimpleDelegator
  def options
    opts = super.dup
    if object.class.multiple?(property)
      opts[:as] = :uri_multi_value
    else
      opts[:as] = :string
    end
    opts
  end
end
