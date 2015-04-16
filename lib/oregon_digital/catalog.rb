module OregonDigital
  module Catalog
    extend ActiveSupport::Concern
    included do
      include OregonDigital::Catalog::SearchFields
    end
  end
end
