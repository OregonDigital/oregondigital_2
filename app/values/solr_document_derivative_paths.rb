class SolrDocumentDerivativePaths
  pattr_initialize :document
  delegate :[], :to => :derivative_paths

  def [](key)
    derivative_paths[key] || NullDerivativePath.instance
  end

  private

  def derivative_paths
    @derivative_paths ||= Hash[all_derivative_paths.
         group_by(&:derivative_type).
         map{|k, v| [k, v.first] }
    ]
  end

  def all_derivative_paths
    derivative_keys.map do |k|
      DerivativePath.new(document[k].first)
    end
  end

  def derivative_keys
    document.keys.select do |k|
      k.start_with?("workflow_metadata") && k.end_with?("path_ssim")
    end
  end

  class NullDerivativePath
    include Singleton
    def to_s
      ""
    end
    
    def present?
      false
    end

    def relative_path
      self
    end

    def derivative_type
      "null"
    end

    def to_iiif
      self
    end
  end
end
