class FormTemplate < ActiveRecord::Base
  has_many :properties, :dependent => :destroy, :class_name => FormTemplateProperty
  accepts_nested_attributes_for :properties

  def visible_terms
    properties.select {|p| p.visible?}.collect {|p| p.name}
  end
end
