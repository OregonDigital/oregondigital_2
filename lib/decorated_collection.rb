class DecoratedCollection
  include Enumerable
  pattr_initialize :collection, :decorator

  def each
    collection.each do |item|
      yield decorator.new(item)
    end
  end
end
