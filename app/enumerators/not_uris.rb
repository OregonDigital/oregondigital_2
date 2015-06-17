##
# An enumerator which iterates only over non-URIs in a given set of values.
class NotUris
  attr_reader :values
  include Enumerable
  def initialize(values)
    @values = Array.wrap(values)
  end

  def each
    values.each do |value|
      if !uri?(value)
        yield value
      end
    end
  end

  private

  def uri?(value)
    MaybeURI.new(value).uri?
  end
end
