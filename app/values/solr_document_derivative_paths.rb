class SolrDocumentDerivativePaths
  pattr_initialize :document
  delegate :[], :to => :derivative_paths

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

end
