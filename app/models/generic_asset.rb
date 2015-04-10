class GenericAsset < ActiveFedora::Base
  include Hydra::AccessControls::Permissions
  include OregonDigital::Models::Metadata
  include OregonDigital::Derivatives::Model
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
