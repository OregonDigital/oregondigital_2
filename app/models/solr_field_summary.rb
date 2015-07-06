class SolrFieldSummary
  class << self
    def where(params={})
      new(
        SolrFieldSummary::Query.new(params).result
      )
    end
  end
  include Enumerable

  pattr_initialize :field_summary_hash
  delegate :keys, :each, :to => :cleaned_result

  def [](key)
    cleaned_result[key.to_sym]
  end

  def keys
    cleaned_result.keys
  end

  private

  def cleaned_result
    @cleaned_result ||= Hash[
      interim_result.map do |k, v|
        [k.key.to_sym, v]
      end
    ]
  end

  def interim_result
    field_summary_hash.each_with_object({}) do |(key, value), collector|
      property = SolrProperty.new(key)
      field = Field.new(value)
      if property.solr_identifier == "ssim"
        collector[property] = field
      end
    end
  end

end
