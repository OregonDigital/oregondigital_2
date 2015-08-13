class FormTemplate < ActiveRecord::Base
  has_many :properties, :dependent => :destroy, :class_name => FormTemplateProperty
  accepts_nested_attributes_for :properties
  before_save :destroy_hidden_properties

  # Syncs up valid property names with the template, adding those not in its
  # properties list and reloading the property map
  def property_names=(names)
    names.each do |name|
      properties.build(:name => name) unless property_map[name]
    end

    rebuild_property_map
  end

  def property_names
    properties.collect(&:name)
  end

  def visible_property_names
    properties.select {|property| property.visible?}.collect(&:name)
  end

  def property_map
    @property_map || rebuild_property_map
  end

  protected

  def destroy_hidden_properties
    properties.destroy(properties.select{|property| !property.visible?})
  end

  def rebuild_property_map
    @property_map = HashWithIndifferentAccess.new
    properties.each {|property| @property_map[property.name] = property}
    @property_map
  end
end
