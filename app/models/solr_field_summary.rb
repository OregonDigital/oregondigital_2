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
    sorted_field_summary.each_with_object({}) do |(key, value), collector|
      property = SolrProperty.new(key)
      field = Field.new(value)
      collector[property] = field
    end
  end

  # Sort by key length so that non-derivative properties come first.
  def sorted_field_summary
    field_summary_hash.sort_by{|k, _| k.to_s.length}.select do |k, v|
      SolrProperty.new(k).solr_identifier == "ssim"
    end
  end
end
