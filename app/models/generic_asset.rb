class GenericAsset < ActiveFedora::Base
  include Hydra::AccessControls::Permissions
  include OregonDigital::Models::Metadata
  include OregonDigital::Derivatives::Model
  contains "content", :class_name => 'FileContent'
  contains "workflow_metadata", :class_name => "Files::YmlFile"

  private

  def injector
    @injector ||= OregonDigital.inject
  end
  
  def assign_id
    OregonDigital::IdService.mint
  end
end
