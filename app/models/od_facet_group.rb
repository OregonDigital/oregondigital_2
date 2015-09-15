class ODFacetGroup
  class << self 

  #instead of calling these properties, which is confusing
  facetgroup :ubercreator, :members => [:creator, :contributor]
  facetgroup :ubergeo, :members => [:spatial, :tgn]
  
  def facetgroup_properties
    facetgroup_properties ||= []
  end

  def facetgroup_property

    facetgroup.each |name, members| do
      members.each |member| do
        facetgroup_properties << member => name
      end
    end
  end

#it would be nice to just get these versions of the facetgroup_properties
  def pref_label
    name + "_preferred_label_ssim"
  end

  def ssim
    name + "_ssim"
  end

  

end
