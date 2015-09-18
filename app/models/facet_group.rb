class FacetGroup < DataModel

  property :creator, :uberfield => :ubercreator
  property :contributor, :uberfield => :ubercreator
  property :author, :uberfield => :ubercreator
  property :spatial, :uberfield => :ubergeographic

 
  def simple_properties
  end

  def self.pref_label(symbol)
    symbol.to_s + "_preferred_label_ssim"
  end

  def self.ssim(symbol)
    symbol.to_s + "_ssim"
  end


  def self.uber_properties
    uber_properties ||= []
    properties.group_by{|property| property.uberfield}.each do |key, val|
      uber_properties << Hash[key => "All " + key.to_s.gsub('uber',"").capitalize + " types"]
    end
    uber_properties
  end

end
