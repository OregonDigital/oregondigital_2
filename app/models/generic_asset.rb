class GenericAsset < ActiveFedora::Base
  include Hydra::AccessControls::Permissions
  include OregonDigital::Models::Metadata
  include OregonDigital::Derivatives::Model
  contains "content", :class_name => 'FileContent'
  contains "workflow_metadata", :class_name => "Files::YmlFile"
  delegate :content_changed?, :to => :content, :prefix => true
  delegate :streamable_content, :to => :content

  def injector
    @injector ||= OregonDigital.inject
  end

  def content_content_changed?
    if content.content.blank?
      false
    else
      content.content_changed?
    end
  end

  private

  def assign_id
    OregonDigital::IdService.mint
  end
end
