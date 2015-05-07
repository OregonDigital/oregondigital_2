class ODDataModel < DataModel
  # Titles
  property :title, :predicate => RDF::DC.title
  property :alternative, :predicate => RDF::DC.alternative
  property :captionTitle, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.captionTitle
  property :tribalTitle, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tribalTitle

  # Creators
  property :creator, :predicate => RDF::DC11.creator
  property :contributor, :predicate => RDF::DC11.contributor
  property :arranger, :predicate => OregonDigital::Vocabularies::MARCREL.arr
  property :artist, :predicate => OregonDigital::Vocabularies::MARCREL.art
  property :author, :predicate => OregonDigital::Vocabularies::MARCREL.aut
  property :cartographer, :predicate => OregonDigital::Vocabularies::MARCREL.ctg
  property :composer, :predicate => OregonDigital::Vocabularies::MARCREL.cmp
  property :donor, :predicate => OregonDigital::Vocabularies::MARCREL.dnr
  property :illustrator, :predicate => OregonDigital::Vocabularies::MARCREL.ill
  property :interviewee, :predicate => OregonDigital::Vocabularies::MARCREL.ive
  property :interviewer, :predicate => OregonDigital::Vocabularies::MARCREL.ivr
  property :lyricist, :predicate => OregonDigital::Vocabularies::MARCREL.lyr
  property :photographer, :predicate => OregonDigital::Vocabularies::MARCREL.pht
  property :printMaker, :predicate => OregonDigital::Vocabularies::MARCREL.prm
  property :scribe, :predicate => OregonDigital::Vocabularies::MARCREL.scr
  property :transcriber, :predicate => OregonDigital::Vocabularies::MARCREL.trc
  property :creatorDisplay, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE['cco/creatorDisplay']
  property :collector, :predicate => OregonDigital::Vocabularies::MARCREL.col

  # Descriptions
  property :description, :predicate => RDF::DC.description
  property :abstract, :predicate => RDF::DC.abstract
  property :inscription, :predicate => OregonDigital::Vocabularies::VRA.inscription
  property :view, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE['cco/viewDescription']
  property :firstLine, :predicate => OregonDigital::Vocabularies::SHEETMUSIC.firstLine
  property :firstLineChorus, :predicate => OregonDigital::Vocabularies::SHEETMUSIC.firstLineChorus
  property :compassDirection, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.compassDirection
  property :objectOrientation, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.objectOrientation
  property :photographOrientation, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.photographOrientation
  property :conditionOfSource, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.sourceCondition
  property :instrumentation, :predicate => OregonDigital::Vocabularies::SHEETMUSIC.instrumentation
  property :od_content, :predicate => RDF::URI('http://opaquenamespace.org/ns/contents')
  property :militaryServiceLocation, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.militaryServiceLocation
  property :militaryHighestRank, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.militaryHighestRank
  property :militaryOccupation, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.militaryOccupation
  property :cover, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.coverDescription
  property :canzonierePoems, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.canzonierePoems
  property :coverage, :predicate => RDF::DC11.coverage
  property :provenance, :predicate => RDF::DC.provenance
  property :tableOfContents, :predicate => RDF::DC.tableOfContents
  property :tribalNotes, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tribalNotes
  property :acceptedNameUsage, :predicate => RDF::URI('http://rs.tdwg.org/dwc/terms/acceptedNameUsage')
  property :originalNameUsage, :predicate => RDF::URI('http://rs.tdwg.org/dwc/terms/originalNameUsage')
  property :specimenType, :predicate => RDF::URI('http://opaquenamespace.org/ns/specimenType')
  property :temporal, :predicate => RDF::DC.temporal

  # Subjects
  # :lcsubject is controlled subject using multiple vocabs
  property :lcsubject, :predicate => RDF::DC.subject
  # :subject is for keywords
  property :subject, :predicate => RDF::DC11.subject
  property :stateEdition, :predicate => OregonDigital::Vocabularies::VRA.stateEdition
  property :stylePeriod, :predicate => OregonDigital::Vocabularies::VRA.hasStylePeriod
  property :workType, :predicate => RDF.type
  property :militaryBranch, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.militaryBranch
  property :ethnographicTerm, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.ethnographic
  property :sportsTeam, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.sportsTeam
  property :tribalClasses, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tribalClasses
  property :tribalTerms, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tribalTerms


  # Geographics
  property :geobox, :predicate => RDF::URI('https://schema.org/box')
  property :latitude, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#gpsLatitude')
  property :longitude, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#gpsLongitude')
  property :location, :predicate => RDF::DC.spatial
  property :streetAddress, :predicate => RDF::URI('http://www.loc.gov/standards/mads/rdf/v1.html#streetAddress')
  property :rangerDistrict, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.rangerDistrict
  property :tgn, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tgn

  # Dates
  property :date, :predicate => RDF::DC.date
  property :earliestDate, :predicate => OregonDigital::Vocabularies::VRA.earliestDate
  property :issued, :predicate => RDF::DC.issued
  property :latestDate, :predicate => OregonDigital::Vocabularies::VRA.latestDate
  property :viewDate, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE['cco/viewDate']
  property :awardDate, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.awardDate
  property :collectedDate, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.collectedDate

  # Identifiers
  property :identifier, :predicate => RDF::DC.identifier
  property :itemLocator, :predicate => OregonDigital::Vocabularies::HOLDING.label
  property :accessionNumber, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE['cco/accessionNumber']
  property :lccn, :predicate => OregonDigital::Vocabularies::BIBFRAME.lccn
  property :barcode, :predicate => OregonDigital::Vocabularies::BIBFRAME.barcode

  # Rights
  property :rights, :predicate => RDF::DC.rights
  property :rightsHolder, :predicate => RDF::URI('http://opaquenamespace.org/rights/rightsHolder')
  property :useRestrictions, :predicate => OregonDigital::Vocabularies::ARCHIVESHUB.useRestrictions
  property :accessRestrictions, :predicate => OregonDigital::Vocabularies::ARCHIVESHUB.accessRestrictions
  property :license, :predicate => OregonDigital::Vocabularies::CCREL.license
  property :copyrightClaimant, :predicate => OregonDigital::Vocabularies::MARCREL.cpc

  # Publishing / Source
  property :source, :predicate => RDF::DC.source
  property :language, :predicate => RDF::DC.language
  property :publisher, :predicate => RDF::DC.publisher
  property :placeOfPublication, :predicate => OregonDigital::Vocabularies::MARCREL.pup
  property :od_repository, :predicate => OregonDigital::Vocabularies::MARCREL.rps
  property :localCollectionID, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.localCollectionID
  property :localCollectionName, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.localCollectionName
  property :seriesName, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.seriesName
  property :seriesNumber, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.seriesNumber
  property :boxNumber, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.boxNumber
  property :folderNumber, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.folderNumber
  property :folderName, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.folderName

  # Types
  property :dc_type, :predicate => RDF::DC.type

  # Formats
  property :format, :predicate => RDF::DC.format
  property :physicalExtent, :predicate => RDF::URI('http://www.loc.gov/standards/mods/modsrdf/v1#physicalExtent')
  property :extent, :predicate => RDF::DC.extent
  property :measurements, :predicate => OregonDigital::Vocabularies::VRA.measurements
  property :material, :predicate => OregonDigital::Vocabularies::VRA.material
  property :support, :predicate => OregonDigital::Vocabularies::VRA.support
  property :technique, :predicate => OregonDigital::Vocabularies::VRA.hasTechnique

  # Groupings
  property :set, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.set

  # Relations
  property :relation, :predicate => RDF::DC.relation
  property :largerWork, :predicate => OregonDigital::Vocabularies::SHEETMUSIC.largerWork
  property :artSeries, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.artSeries
  property :hostItem, :predicate => OregonDigital::Vocabularies::SHEETMUSIC.hostItem
  property :hasPart, :predicate => RDF::DC.hasPart
  property :isPartOf, :predicate => RDF::DC.isPartOf
  property :hasVersion, :predicate => RDF::DC.hasVersion
  property :isVersionOf, :predicate => RDF::DC.isVersionOf
  property :findingAid, :predicate => RDF::URI('http://lod.xdams.org/reload/oad/has_findingAid')

  # Administrative
  property :institution, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.contributingInstitution
  property :conversion, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.conversionSpecifications
  property :dateDigitized, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.dateDigitized
  property :created, :predicate => RDF::DC.created
  property :modified, :predicate => RDF::DC.modified
  property :exhibit, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.exhibit
  property :fullText, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.fullText
  property :tribalStatus, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tribalStatus
  property :submissionDate, :predicate => RDF::DC.dateSubmitted
  property :replacesUrl, :predicate => RDF::DC.replaces

  # Schema.org
  property :citation, :predicate => RDF::SCHEMA.citation
  property :editor, :predicate => RDF::SCHEMA.editor
  property :numberOfPages, :predicate => RDF::SCHEMA.numberOfPages
  property :event, :predicate => RDF::SCHEMA.event

  # Darwin Core
  property :taxonClass, :predicate => OregonDigital::Vocabularies::DWC.Class
  property :order, :predicate => OregonDigital::Vocabularies::DWC.order
  property :family, :predicate => OregonDigital::Vocabularies::DWC.family
  property :genus, :predicate => OregonDigital::Vocabularies::DWC.genus
  property :phylum, :predicate => OregonDigital::Vocabularies::DWC.phylum
  property :higherClassification, :predicate => OregonDigital::Vocabularies::DWC.higherClassification
  property :commonNames, :predicate => OregonDigital::Vocabularies::DWC.vernacularName
  property :identificationVerificationStatus, :predicate => OregonDigital::Vocabularies::DWC.identificationVerificationStatus

  # PREMIS
  property :preservation, :predicate => OregonDigital::Vocabularies::PREMIS.hasOriginalName
  property :hasFixity, :predicate => OregonDigital::Vocabularies::PREMIS.hasFixity

  # MODS RDF
  property :locationCopySublocation, :predicate => RDF::URI('http://www.loc.gov/standards/mods/modsrdf/v1#locationCopySublocation')
  property :locationCopyShelfLocator, :predicate => RDF::URI('http://www.loc.gov/standards/mods/modsrdf/v1#locationCopyShelfLocator')
  property :note, :predicate => RDF::URI('http://www.loc.gov/standards/mods/modsrdf/v1#note')

  # VRA
  property :culturalContext, :predicate => OregonDigital::Vocabularies::VRA.culturalContext
  property :idCurrentRepository, :predicate => OregonDigital::Vocabularies::VRA.idCurrentRepository

  # EXIF
  property :imageWidth, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#width')
  property :imageHeight, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#height')
  property :imageResolution, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#resolution')
  property :imageOrientation, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#orientation')
  property :colorSpace, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#colorSpace')

  # RDA
  property :formOfWork, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/w/formOfWork.en')
  property :fileSize, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/fileSize.en')
  property :layout, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/layout.en')
  property :containedInManifestation, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/containedInManifestation.en')
  property :modeOfIssuance, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/modeOfIssuance.en')
  property :placeOfProduction, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/placeOfProduction.en')
  property :descriptionOfManifestation, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/descriptionOfManifestation.en')
  property :colourContent, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/e/colourContent.en')
  property :biographicalInformation, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/a/biographicalInformation.en')

  # SWPO
  property :containedInJournal, :predicate => RDF::URI('http://sw-portal.deri.org/ontologies/swportal#containedInJournal')
  property :isVolume, :predicate => RDF::URI('http://sw-portal.deri.org/ontologies/swportal#isVolume')
  property :hasNumber, :predicate => RDF::URI('http://sw-portal.deri.org/ontologies/swportal#hasNumber')
end

