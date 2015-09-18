class SearchBuilder < Hydra::SearchBuilder
  attr_accessor :set

  # Restricts result sets to a Set object.
  def restrict_to_set(solr_params)
    if set && set.respond_to?(:uri)
      solr_params[:fq] ||= []
      solr_params[:fq] << "#{ActiveFedora::SolrQueryBuilder.solr_name("set", :symbol)}:#{RSolr.solr_escape(set.uri)}"
    end
  end

  def filter_sets(solr_params)
    solr_params[:fq] ||= []
    if remove_items.any?
      filter = remove_items.map { |i| "-\"#{i}\"" }.join("")
      solr_params[:fq] << "set_ssim:("+filter+")"
    end
  end

  def only_unreviewed(solr_params)
    solr_params[:fq] ||= []
    solr_params[:fq] << "reviewed_bsi:false"
  end

  private

  def remove_items
    items ||= []
    FacetItem.all.each do |item|
      unless item.visible?
        items << item.value
      end
    end
    items
  end

end
