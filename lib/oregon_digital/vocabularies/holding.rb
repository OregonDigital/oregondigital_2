# -*- encoding: utf-8 -*-
# This file generated automatically using vocab-fetch from http://purl.org/ontology/holding#
require 'rdf'
module OregonDigital::Vocabularies
  class HOLDING < RDF::StrictVocabulary("http://purl.org/ontology/holding#")

    # Class definitions
    term :Agent,
      comment: %(Use one of bf:Agent or foaf:Agent).freeze,
      label: "Agent".freeze,
      type: "owl:Class".freeze
    term :Document,
      comment: %(Use one of bibo:Document, foaf:Document, bf:Work or bf:Instance).freeze,
      label: "Document".freeze,
      type: "owl:Class".freeze
    term :Item,
      comment: %(Use one of bf:HeldItem frbr:Item rdac:Item).freeze,
      label: "Item".freeze,
      type: "owl:Class".freeze

    # Property definitions
    property :broaderExemplar,
      comment: %(Relates a document to an item that contains an exemplar of the document as part.).freeze,
      domain: "http://purl.org/ontology/holding#Document".freeze,
      label: "broader exemplar".freeze,
      "owl:inverseOf" => %(http://purl.org/ontology/holding#broaderExemplarOf).freeze,
      range: "http://purl.org/ontology/holding#Item".freeze,
      "rdfs:seeAlso" => %(http://rdaregistry.info/Elements/i/containedInItem).freeze,
      type: "owl:ObjectProperty".freeze
    property :broaderExemplarOf,
      comment: %(Relates an item to a document which is partly exemplified by the item.).freeze,
      domain: "http://purl.org/ontology/holding#Item".freeze,
      label: "broader exemplar of".freeze,
      "owl:inverseOf" => %(http://purl.org/ontology/holding#broaderExemplar).freeze,
      range: "http://purl.org/ontology/holding#Document".freeze,
      "rdfs:seeAlso" => %(http://rdaregistry.info/Elements/i/containsItem).freeze,
      type: "owl:ObjectProperty".freeze
    property :collectedBy,
      comment: [%(Relates a document and/or item to an agent who collects it.).freeze, %(Relates an agent to a document and/or item that is collected by the agent.).freeze],
      domain: ["http://purl.org/ontology/holding#Agent".freeze, "http://purl.org/ontology/holding#Document".freeze, "http://purl.org/ontology/holding#Item".freeze],
      label: ["collected by".freeze, "collects".freeze],
      "owl:inverseOf" => [%(http://purl.org/ontology/holding#collectedBy).freeze, %(http://purl.org/ontology/holding#collects).freeze],
      range: ["http://purl.org/ontology/holding#Agent".freeze, "http://purl.org/ontology/holding#Document".freeze, "http://purl.org/ontology/holding#Item".freeze],
      "rdfs:seeAlso" => [%(http://rdaregistry.info/Elements/i/collector).freeze, %(http://rdaregistry.info/Elements/i/collectorOf).freeze],
      type: "owl:ObjectProperty".freeze
    property :exemplar,
      comment: %(Relates a document to an item that is an exemplar of the document.).freeze,
      domain: "http://purl.org/ontology/holding#Document".freeze,
      label: "has exemplar".freeze,
      "owl:inverseOf" => %(http://purl.org/ontology/holding#exemplarOf).freeze,
      range: "http://purl.org/ontology/holding#Item".freeze,
      "rdfs:seeAlso" => [%(http://purl.org/vocab/frbr/core#exemplar).freeze, %(http://rdaregistry.info/Elements/m/exemplarOfManifestation).freeze],
      type: "owl:ObjectProperty".freeze
    property :exemplarOf,
      comment: %(Relates an item to the document that is exemplified by the item.).freeze,
      domain: "http://purl.org/ontology/holding#Item".freeze,
      label: "is examplar of".freeze,
      "owl:inverseOf" => %(http://purl.org/ontology/holding#exemplar).freeze,
      range: "http://purl.org/ontology/holding#Document".freeze,
      "rdfs:seeAlso" => [%(http://bibframe.org/vocab/holdingFor).freeze, %(http://rdaregistry.info/Elements/i/manifestationExemplified).freeze],
      type: "owl:ObjectProperty".freeze
    property :heldBy,
      comment: %(Relates an item to an agent who holds the item.).freeze,
      domain: "http://purl.org/ontology/holding#Item".freeze,
      label: "held by".freeze,
      "owl:inverseOf" => %(http://purl.org/ontology/holding#holds).freeze,
      range: "http://purl.org/ontology/holding#Agent".freeze,
      "rdfs:seeAlso" => [%(http://bibframe.org/vocab/heldBy).freeze, %(http://rdaregistry.info/Elements/i/currentOwner).freeze, %(http://rdaregistry.info/Elements/i/owner).freeze],
      subPropertyOf: "http://purl.org/ontology/holding#collectedBy".freeze,
      type: "owl:ObjectProperty".freeze
    property :holds,
      comment: %(Relates an agent to an item which the agent holds.).freeze,
      domain: "http://purl.org/ontology/holding#Agent".freeze,
      label: "holds".freeze,
      "owl:inverseOf" => %(http://purl.org/ontology/holding#heldBy).freeze,
      range: "http://purl.org/ontology/holding#Item".freeze,
      "rdfs:seeAlso" => [%(http://rdaregistry.info/Elements/a/currentOwnerOf).freeze, %(http://rdaregistry.info/Elements/a/ownerOf).freeze],
      subPropertyOf: "http://purl.org/ontology/holding#collects".freeze,
      type: "owl:ObjectProperty".freeze
    property :label,
      comment: %(A call number, shelf mark or similar label of an item).freeze,
      domain: "http://purl.org/ontology/holding#Item".freeze,
      label: "label".freeze,
      range: "rdfs:Literal".freeze,
      "rdfs:seeAlso" => [%(http://bibframe.org/vocab/label).freeze, %(http://bibframe.org/vocab/shelfMark).freeze, %(gr:hasStockKeepingUnit).freeze, %(http://rdaregistry.info/Elements/i/identifierForTheItem).freeze, %(schema:name).freeze, %(schema:sku).freeze],
      subPropertyOf: "dc:identifier".freeze,
      type: "owl:DatatypeProperty".freeze
    property :narrowerExemplar,
      comment: %(Relates a document to an item that is an exemplar of a part of the document.).freeze,
      domain: "http://purl.org/ontology/holding#Document".freeze,
      label: "narrower exemplar".freeze,
      "owl:inverseOf" => %(http://purl.org/ontology/holding#narrowerExemplarOf).freeze,
      range: "http://purl.org/ontology/holding#Item".freeze,
      "rdfs:seeAlso" => %(http://rdaregistry.info/Elements/i/containsItem).freeze,
      type: "owl:ObjectProperty".freeze
    property :narrowerExemplarOf,
      comment: %(Relates an item to a document which is partly exemplified by the item.).freeze,
      domain: "http://purl.org/ontology/holding#Item".freeze,
      label: "narrower exemplar of".freeze,
      "owl:inverseOf" => %(http://purl.org/ontology/holding#narrowerExemplar).freeze,
      range: "http://purl.org/ontology/holding#Document".freeze,
      "rdfs:seeAlso" => %(http://rdaregistry.info/Elements/i/containedInItem).freeze,
      type: "owl:ObjectProperty".freeze
  end
end
