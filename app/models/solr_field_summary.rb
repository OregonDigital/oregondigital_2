class SolrFieldSummary
  class << self
    def where(params={})
      new(
        Query.new(params).result
      )
    end
  end

  pattr_initialize :field_summary_hash
  delegate :keys, :to => :cleaned_result

  def [](key)
    cleaned_result[key.to_sym]
  end

  def keys
    cleaned_result.keys
  end

  private

  def cleaned_result
    derivative_properties = []
    field_summary_hash.sort_by{|k, _| k.to_s.length }.each_with_object({}) do |(key, value), collector|
      property = SolrProperty.new(key)
      unless derivative_properties.include?(key)
        field = Field.new(value)
        property.derivative_properties.each do |derivative_property_key, prop|
          derivative_properties << prop.property_key
          field.derivative_properties[derivative_property_key] = Field.new(field_summary_hash[prop.property_key])
        end
        collector[property.key.to_sym] = field
      end
    end
  end

  class Field < OpenStruct
    def derivative_properties
      @derivative_properties ||= {}
    end
  end

  class Query
    attr_reader :field
    def initialize(field:)
      @field = field
    end

    def result
      @result ||= solr_result["fields"]
    end

    private

    def solr_result
      solr.send_and_receive("admin/luke", :params => solr_params)
    end

    def solr_params
      {
        :fl => field
      }
    end

    def solr
      ActiveFedora.solr.conn
    end
  end
end
