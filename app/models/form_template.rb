class FormTemplate < ActiveRecord::Base
  has_many :properties, :dependent => :destroy, :class_name => FormTemplateProperty
  accepts_nested_attributes_for :properties

  def visible_property_names
    properties.where(:visible => true).pluck(:name)
  end
end
