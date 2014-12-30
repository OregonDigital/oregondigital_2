class GenericAsset < ActiveFedora::Base
  def assign_id
    OregonDigital::IdService.mint
  end
end
