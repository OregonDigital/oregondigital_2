class FormTemplate < ActiveRecord::Base
  has_many :properties, :dependent => :destroy, :class_name => FormTemplateProperty
  accepts_nested_attributes_for :properties
end
