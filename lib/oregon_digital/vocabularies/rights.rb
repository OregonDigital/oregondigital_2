# -*- encoding: utf-8 -*-
# This file generated automatically using vocab-fetch from https://raw.github.com/OregonDigital/opaque_ns/master/rights.jsonld
require 'rdf'
module OregonDigital::Vocabularies
  class RIGHTS < RDF::StrictVocabulary("http://opaquenamespace.org/rights/")

    # Extra definitions
    term :educational,
      "dc:description" => %(Educational use is permitted without permission. Permission may be required for additional uses.).freeze,
      label: "Educational Use Permitted".freeze,
      type: "dc:RightsStatement".freeze
    term :"orphan-work-us",
      "dc:description" => %(The Orphan works statement can be applied to objects that have been identified as orphan works in the country of first publication and in line with the requirements of the country. This rights statement applies to orphan works as defined in the United States of America. When an object has an orphan work statement, a good faith effort has been applied to try to identify the copyright holder and seek permission.).freeze,
      label: "Orphan Work".freeze,
      type: "dc:RightsStatement".freeze
  end
end
