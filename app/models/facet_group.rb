class FacetGroup < DataModel

  property :creator, :uberfield => :ubercreator
  property :contributor, :uberfield => :ubercreator
  property :author, :uberfield => :ubercreator

  #override?
  def simple_properties
  end

  def pref_label(symbol)
    symbol.to_s + "_preferred_label_ssim"
  end

  def ssim(symbol)
    symbol.to_s + "_ssim"
  end
end
