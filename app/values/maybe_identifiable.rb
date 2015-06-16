##
# Class for encapsulating that something may be powered by an RDFSource. If it
# is, value returns it, otherwise it returns the given object.
class MaybeIdentifiable
  pattr_initialize :value

  def value
    if @value.respond_to?(:resource)
      @value.resource
    else
      @value
    end
  end
end
