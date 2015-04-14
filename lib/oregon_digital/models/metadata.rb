module OregonDigital::Models
  module Metadata
    extend ActiveSupport::Concern
    included do
      ODDataModel.properties.each do |property_name, config|
        property property_name, :predicate => config.predicate, :class_name => config.class_name do |index|
          index.as :searchable, :displayable, :facetable
        end
      end
    end
  end
end
