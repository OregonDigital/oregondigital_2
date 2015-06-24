class SingularSolrProperty < SolrProperty
  def values
    super.first
  end
end
