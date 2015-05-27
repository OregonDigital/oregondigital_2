class SparqlWithContext < SPARQL::Client
  attr_reader :context
  def initialize(context, *args)
    @context = context
    super(*args)
  end
  def insert_data(data, options={})
    options[:graph] ||= context
    super
  end
end
