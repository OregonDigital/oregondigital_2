# Decorator for OregonDigital::Fields::InputFactory to allow the URI-enabled
# input type.
#
# @note We purposely don't allow single-value URI-enabled fields for now, and
# those will just fall through here with no changes.
class HasURIInputType < SimpleDelegator
  def options
    opts = super.dup
    if object.class.multiple?(property)
      opts[:as] = :uri_multi_value
    end
    opts
  end
end
