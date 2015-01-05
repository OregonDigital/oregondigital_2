module OregonDigital
  module Catalog
    extend ActiveSupport::Concern
    included do
      include OregonDigital::Catalog::Defaults
      include OregonDigital::Catalog::ViewConfiguration
      include OregonDigital::Catalog::Facets
      include OregonDigital::Catalog::IndexFields
      include OregonDigital::Catalog::SearchFields
    end
  end
end
