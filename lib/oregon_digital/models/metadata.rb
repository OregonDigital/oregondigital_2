module OregonDigital::Models
  module Metadata
    extend ActiveSupport::Concern
    included do
      property :title, :predicate => RDF::DC.title
    end
  end
end
