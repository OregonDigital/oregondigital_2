# -*- encoding: utf-8 -*-
# This file generated automatically using vocab-fetch from https://raw.github.com/OregonDigital/opaque_ns/master/eurights/rightsstatements.nt
require 'rdf'
module OregonDigital::Vocabularies
  class EURIGHTS < RDF::StrictVocabulary("http://www.europeana.eu/rights/")

    # Extra definitions
    term :"rr-f/",
      "dc11:creator" => %(http://europeana.eu).freeze,
      "dc11:title" => %(Rights Reserved - Free Access).freeze,
      label: "rr-f/".freeze,
      type: "cc:License".freeze
    term :"rr-f/#header",
      label: "rr-f/#header".freeze,
      "xhv:role" => %(xhv:banner).freeze
    term :"rr-r/",
      "dc11:creator" => %(http://europeana.eu).freeze,
      "dc11:title" => %(Rights Reserved - Restricted Access).freeze,
      label: "rr-r/".freeze,
      type: "cc:License".freeze
    term :"unknown/",
      "dc11:creator" => %(http://europeana.eu).freeze,
      "dc11:title" => %(Unknown copyright status).freeze,
      label: "unknown/".freeze,
      type: "cc:License".freeze
    term :"unknown/#header",
      label: "unknown/#header".freeze,
      "xhv:role" => %(xhv:banner).freeze
  end
end
