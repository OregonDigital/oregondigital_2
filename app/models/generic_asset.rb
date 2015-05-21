class GenericAsset < ActiveFedora::Base
  include Hydra::AccessControls::Permissions
  include OregonDigital::Derivatives::Model
  # DSL to apply a data model with a given strategy.
  # @note We should push this up to either AF or ActiveTriples.
  def self.apply_data_model(model, strategy)
    ApplyProperties.new(model.properties, strategy).apply!(self)
  end
  apply_data_model DecoratedODDataModel, SolrApplicationStrategy.new
  contains "content", :class_name => 'FileContent'
  contains "workflow_metadata", :class_name => "Files::YmlFile"
  delegate :content_changed?,:blank?, :to => :content, :prefix => true
  delegate :streamable_content, :to => :content

  def injector
    @injector ||= OregonDigital.inject
  end

  private

  def assign_id
    injector.id_service.mint.reverse
  end
end
