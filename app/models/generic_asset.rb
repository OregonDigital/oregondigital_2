class GenericAsset < ActiveFedora::Base
  include Hydra::AccessControls::Permissions
  include OregonDigital::Models::Metadata
  include OregonDigital::Derivatives::Model
  contains "content", :class_name => 'FileContent'
  contains "workflow_metadata", :class_name => "Files::YmlFile"

  def injector
    @injector ||= OregonDigital.inject
  end

  private

  def assign_id
    OregonDigital::IdService.mint
  end
end
