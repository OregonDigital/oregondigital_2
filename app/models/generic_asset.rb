class GenericAsset < ActiveFedora::Base
  include Hydra::AccessControls::Permissions
  include OregonDigital::Models::Metadata

  def assign_rdf_subject
    super
  end

  private

  def assign_id
    OregonDigital::IdService.mint
  end
end
