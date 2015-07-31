class ShowField
  attr_reader :property
  def initialize(property)
    @property = property.to_s
  end

  def key
    solr_name_generator.solr_name(property, :symbol)
  end

  def label
    Rails.cache.fetch("label:#{property}") do
      h.content_tag :span, :title => comment, :data => {:predicate => predicate.to_s}.merge(tooltip_params) do
        found_label.titleize
      end.html_safe
    end
  end

  private

  def found_label
    if predicate_resource && (label = predicate_resource.rdf_label.first) != predicate_resource.rdf_subject.to_s
      label
    else
      property.humanize
    end
  end

  def tooltip_params
    if predicate
      {
        :toggle => "tooltip"
      }
    else
      {}
    end
  end

  def comment
    if predicate_resource
      (predicate_resource.get_values(RDF::RDFS.comment) + predicate_resource.get_values(RDF::URI("http://www.loc.gov/mads/rdf/v1#definitionNote"))).first
    end
  end

  def predicate
    @predicate ||= GenericAsset.properties[property].try(:predicate)
  end

  def predicate_resource
    if predicate.present? && predicate.start_with?("http")
      TriplePoweredResource.new(predicate)
    end
  end

  def h
    ActionController::Base.helpers
  end

  def solr_name_generator
    ActiveFedora::SolrQueryBuilder
  end
end
