module OregonDigital::Models
  module Metadata
    extend ActiveSupport::Concern
    included do
      # Titles
      property :title, :predicate => RDF::DC.title do |index|
        index.as :searchable, :displayable
      end
      property :alternative, :predicate => RDF::DC.alternative do |index|
        index.as :searchable, :displayable
      end
      property :captionTitle, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.captionTitle do |index|
        index.as :searchable, :displayable
      end
      property :tribalTitle, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tribalTitle do |index|
        index.as :searchable, :displayable
      end

      # Creators
      property :creator, :predicate => RDF::DC11.creator do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :contributor, :predicate => RDF::DC11.contributor do |index|
        index.as :searchable, :displayable
      end
      property :arranger, :predicate => OregonDigital::Vocabularies::MARCREL.arr do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :artist, :predicate => OregonDigital::Vocabularies::MARCREL.art do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :author, :predicate => OregonDigital::Vocabularies::MARCREL.aut do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :cartographer, :predicate => OregonDigital::Vocabularies::MARCREL.ctg do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :composer, :predicate => OregonDigital::Vocabularies::MARCREL.cmp do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :donor, :predicate => OregonDigital::Vocabularies::MARCREL.dnr do |index|
        index.as :searchable, :displayable
      end
      property :illustrator, :predicate => OregonDigital::Vocabularies::MARCREL.ill do |index|
        index.as :displayable, :facetable
      end
      property :interviewee, :predicate => OregonDigital::Vocabularies::MARCREL.ive do |index|
        index.as :searchable, :displayable
      end
      property :interviewer, :predicate => OregonDigital::Vocabularies::MARCREL.ivr do |index|
        index.as :searchable, :displayable
      end
      property :lyricist, :predicate => OregonDigital::Vocabularies::MARCREL.lyr do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :photographer, :predicate => OregonDigital::Vocabularies::MARCREL.pht do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :printMaker, :predicate => OregonDigital::Vocabularies::MARCREL.prm do |index|
        index.as :displayable
      end
      property :scribe, :predicate => OregonDigital::Vocabularies::MARCREL.scr do |index|
        index.as :searchable, :displayable
      end
      property :transcriber, :predicate => OregonDigital::Vocabularies::MARCREL.trc do |index|
        index.as :displayable
      end
      property :creatorDisplay, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE['cco/creatorDisplay'] do |index|
        index.as :displayable
      end
      property :collector, :predicate => OregonDigital::Vocabularies::MARCREL.col do |index|
        index.as :searchable, :displayable
      end

      # Descriptions
      property :description, :predicate => RDF::DC.description do |index|
        index.as :searchable, :displayable, :stored_searchable
      end
      property :abstract, :predicate => RDF::DC.abstract do |index|
        index.as :searchable, :displayable
      end
      property :inscription, :predicate => OregonDigital::Vocabularies::VRA.inscription do |index|
        index.as :searchable, :displayable
      end
      property :view, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE['cco/viewDescription'] do |index|
        index.as :displayable
      end
      property :firstLine, :predicate => OregonDigital::Vocabularies::SHEETMUSIC.firstLine do |index|
        index.as :searchable, :displayable
      end
      property :firstLineChorus, :predicate => OregonDigital::Vocabularies::SHEETMUSIC.firstLineChorus do |index|
        index.as :searchable, :displayable
      end
      property :compassDirection, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.compassDirection do |index|
        index.as :displayable
      end
      property :objectOrientation, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.objectOrientation do |index|
        index.as :displayable
      end
      property :photographOrientation, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.photographOrientation do |index|
        index.as :displayable
      end
      property :conditionOfSource, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.sourceCondition do |index|    
        index.as :searchable, :displayable
      end
      property :instrumentation, :predicate => OregonDigital::Vocabularies::SHEETMUSIC.instrumentation do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :od_content, :predicate => RDF::URI('http://opaquenamespace.org/ns/contents') do |index|
        index.as :symbol
      end
      property :militaryServiceLocation, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.militaryServiceLocation do |index|
        index.as :searchable, :displayable
      end
      property :militaryHighestRank, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.militaryHighestRank do |index|
        index.as :searchable, :displayable
      end
      property :militaryOccupation, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.militaryOccupation do |index|
        index.as :searchable, :displayable
      end
      property :cover, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.coverDescription do |index|
        index.as :searchable, :displayable
      end
      property :canzonierePoems, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.canzonierePoems do |index|
        index.as :displayable
      end
      property :coverage, :predicate => RDF::DC11.coverage do |index|
        index.as :searchable, :displayable
      end
      property :provenance, :predicate => RDF::DC.provenance do |index|
        index.as :displayable
      end
      property :tableOfContents, :predicate => RDF::DC.tableOfContents do |index|
        index.as :displayable
      end
      property :tribalNotes, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tribalNotes do |index|
        index.as :displayable
      end
      property :acceptedNameUsage, :predicate => RDF::URI('http://rs.tdwg.org/dwc/terms/acceptedNameUsage') do |index|
        index.as :displayable
      end
      property :originalNameUsage, :predicate => RDF::URI('http://rs.tdwg.org/dwc/terms/originalNameUsage') do |index|
        index.as :displayable
      end
      property :specimenType, :predicate => RDF::URI('http://opaquenamespace.org/ns/specimenType') do |index|
        index.as :displayable
      end
      property :temporal, :predicate => RDF::DC.temporal do |index|
        index.as :searchable, :displayable
      end

      # Subjects
      # :lcsubject is controlled subject using multiple vocabs
      property :lcsubject, :predicate => RDF::DC.subject do |index|
        index.as :searchable, :facetable, :displayable
      end
      # :subject is for keywords
      property :subject, :predicate => RDF::DC11.subject do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :stateEdition, :predicate => OregonDigital::Vocabularies::VRA.stateEdition do |index|
        index.as :searchable, :displayable
      end
      property :stylePeriod, :predicate => OregonDigital::Vocabularies::VRA.hasStylePeriod do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :workType, :predicate => RDF.type do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :militaryBranch, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.militaryBranch do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :ethnographicTerm, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.ethnographic do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :sportsTeam, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.sportsTeam do |index|
        index.as :searchable, :displayable
      end
      property :tribalClasses, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tribalClasses do |index|
        index.as :searchable, :displayable
      end
      property :tribalTerms, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tribalTerms do |index|
        index.as :searchable, :displayable
      end


      # Geographics
      property :geobox, :predicate => RDF::URI('https://schema.org/box') do |index|
        index.as :searchable, :displayable
      end
      property :latitude, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#gpsLatitude') do |index|
        index.as :searchable, :displayable
      end
      property :longitude, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#gpsLongitude') do |index|
        index.as :searchable, :displayable
      end
      property :location, :predicate => RDF::DC.spatial do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :streetAddress, :predicate => RDF::URI('http://www.loc.gov/standards/mads/rdf/v1.html#streetAddress') do |index|
        index.as :searchable, :displayable
      end
      property :rangerDistrict, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.rangerDistrict do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :tgn, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tgn do |index|
        index.as :searchable, :facetable, :displayable
      end

      # Dates
      property :date, :predicate => RDF::DC.date do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :earliestDate, :predicate => OregonDigital::Vocabularies::VRA.earliestDate do |index|
        index.as :searchable, :displayable
      end
      property :issued, :predicate => RDF::DC.issued do |index|
        index.as :searchable, :displayable
      end
      property :latestDate, :predicate => OregonDigital::Vocabularies::VRA.latestDate do |index|
        index.as :searchable, :displayable
      end
      property :viewDate, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE['cco/viewDate'] do |index|
        index.as :displayable
      end
      property :awardDate, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.awardDate do |index|
        index.as :searchable, :displayable
      end
      property :collectedDate, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.collectedDate do |index|
        index.as :displayable
      end

      # Identifiers
      property :identifier, :predicate => RDF::DC.identifier do |index|
        index.as :searchable, :displayable
      end
      property :itemLocator, :predicate => OregonDigital::Vocabularies::HOLDING.label do |index|
        index.as :searchable, :displayable
      end
      property :accessionNumber, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE['cco/accessionNumber'] do |index|
        index.as :searchable, :displayable
      end
      property :lccn, :predicate => OregonDigital::Vocabularies::BIBFRAME.lccn do |index|
        index.as :searchable, :displayable
      end
      property :barcode, :predicate => OregonDigital::Vocabularies::BIBFRAME.barcode do |index|
        index.as :displayable
      end

      # Rights
      property :rights, :predicate => RDF::DC.rights do |index|
        index.as :searchable, :displayable, :facetable
      end
      property :rightsHolder, :predicate => RDF::URI('http://opaquenamespace.org/rights/rightsHolder') do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :useRestrictions, :predicate => OregonDigital::Vocabularies::ARCHIVESHUB.useRestrictions do |index|
        index.as :searchable, :displayable
      end
      property :accessRestrictions, :predicate => OregonDigital::Vocabularies::ARCHIVESHUB.accessRestrictions do |index|
        index.as :searchable, :displayable
      end
      property :license, :predicate => OregonDigital::Vocabularies::CCREL.license do |index|
        index.as :displayable
      end
      property :copyrightClaimant, :predicate => OregonDigital::Vocabularies::MARCREL.cpc do |index|
        index.as :displayable
      end

      # Publishing / Source
      property :source, :predicate => RDF::DC.source do |index|
        index.as :displayable
      end
      property :language, :predicate => RDF::DC.language do |index|
        index.as :displayable, :facetable
      end
      property :publisher, :predicate => RDF::DC.publisher do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :placeOfPublication, :predicate => OregonDigital::Vocabularies::MARCREL.pup do |index|
        index.as :displayable
      end
      property :od_repository, :predicate => OregonDigital::Vocabularies::MARCREL.rps do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :localCollectionID, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.localCollectionID do |index|
        index.as :searchable, :displayable
      end
      property :localCollectionName, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.localCollectionName do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :seriesName, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.seriesName do |index|
        index.as :searchable, :displayable
      end
      property :seriesNumber, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.seriesNumber do |index|
        index.as :displayable
      end
      property :boxNumber, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.boxNumber do |index|
        index.as :searchable, :displayable
      end
      property :folderNumber, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.folderNumber do |index|
        index.as :searchable, :displayable
      end
      property :folderName, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.folderName do |index|
        index.as :searchable, :displayable
      end

      # Types
      property :dc_type, :predicate => RDF::DC.type do |index|
        index.as :facetable, :displayable
      end

      # Formats
      property :format, :predicate => RDF::DC.format do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :physicalExtent, :predicate => RDF::URI('http://www.loc.gov/standards/mods/modsrdf/v1#physicalExtent') do |index|
        index.as :displayable
      end
      property :extent, :predicate => RDF::DC.extent do |index|
        index.as :searchable, :displayable
      end
      property :measurements, :predicate => OregonDigital::Vocabularies::VRA.measurements do |index|
        index.as :displayable
      end
      property :material, :predicate => OregonDigital::Vocabularies::VRA.material do |index|
        index.as :searchable, :displayable
      end
      property :support, :predicate => OregonDigital::Vocabularies::VRA.support do |index|
        index.as :searchable, :displayable
      end
      property :technique, :predicate => OregonDigital::Vocabularies::VRA.hasTechnique do |index|
        index.as :searchable, :displayable
      end

      # Groupings
      property :set, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.set do |index|
        index.as :searchable, :facetable, :displayable
      end

      # Relations
      property :relation, :predicate => RDF::DC.relation do |index|
        index.as :displayable
      end
      property :largerWork, :predicate => OregonDigital::Vocabularies::SHEETMUSIC.largerWork do |index|
        index.as :searchable, :displayable
      end
      property :artSeries, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.artSeries do |index|
        index.as :searchable, :displayable
      end
      property :hostItem, :predicate => OregonDigital::Vocabularies::SHEETMUSIC.hostItem do |index|
        index.as :displayable
      end
      property :hasPart, :predicate => RDF::DC.hasPart do |index|
        index.as :displayable
      end
      property :isPartOf, :predicate => RDF::DC.isPartOf do |index|
        index.as :searchable, :displayable
      end
      property :hasVersion, :predicate => RDF::DC.hasVersion do |index|
        index.as :displayable
      end
      property :isVersionOf, :predicate => RDF::DC.isVersionOf do |index|
        index.as :displayable
      end
      property :findingAid, :predicate => RDF::URI('http://lod.xdams.org/reload/oad/has_findingAid') do |index|
        index.as :displayable
      end

      # Administrative
      property :institution, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.contributingInstitution do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :conversion, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.conversionSpecifications
      property :dateDigitized, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.dateDigitized
      property :created, :predicate => RDF::DC.created do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :modified, :predicate => RDF::DC.modified do |index|
        index.as :searchable, :displayable
      end
      property :exhibit, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.exhibit do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :fullText, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.fullText do |index|
        index.as :searchable, :displayable
      end
      property :tribalStatus, :predicate => OregonDigital::Vocabularies::OPAQUENAMESPACE.tribalStatus do |index|
        index.as :searchable, :displayable
      end
      property :submissionDate, :predicate => RDF::DC.dateSubmitted do |index|
        index.as :searchable, :displayable
      end
      property :replacesUrl, :predicate => RDF::DC.replaces do |index|
        index.as :symbol
      end

      # Schema.org
      property :citation, :predicate => RDF::SCHEMA.citation do |index|
        index.as :searchable, :displayable
      end
      property :editor, :predicate => RDF::SCHEMA.editor do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :numberOfPages, :predicate => RDF::SCHEMA.numberOfPages do |index|
        index.as :facetable, :displayable
      end
      property :event, :predicate => RDF::SCHEMA.event do |index|
        index.as :facetable, :displayable
      end

      # Darwin Core
      property :taxonClass, :predicate => OregonDigital::Vocabularies::DWC.Class do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :order, :predicate => OregonDigital::Vocabularies::DWC.order do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :family, :predicate => OregonDigital::Vocabularies::DWC.family do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :genus, :predicate => OregonDigital::Vocabularies::DWC.genus do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :phylum, :predicate => OregonDigital::Vocabularies::DWC.phylum do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :higherClassification, :predicate => OregonDigital::Vocabularies::DWC.higherClassification do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :commonNames, :predicate => OregonDigital::Vocabularies::DWC.vernacularName do |index|
        index.as :searchable, :facetable, :displayable
      end
      property :identificationVerificationStatus, :predicate => OregonDigital::Vocabularies::DWC.identificationVerificationStatus do |index|
        index.as :searchable, :facetable, :displayable
      end

      # PREMIS
      property :preservation, :predicate => OregonDigital::Vocabularies::PREMIS.hasOriginalName
      property :hasFixity, :predicate => OregonDigital::Vocabularies::PREMIS.hasFixity

      # MODS RDF
      property :locationCopySublocation, :predicate => RDF::URI('http://www.loc.gov/standards/mods/modsrdf/v1#locationCopySublocation') do |index|
        index.as :displayable
      end
      property :locationCopyShelfLocator, :predicate => RDF::URI('http://www.loc.gov/standards/mods/modsrdf/v1#locationCopyShelfLocator') do |index|
        index.as :displayable
      end
      property :note, :predicate => RDF::URI('http://www.loc.gov/standards/mods/modsrdf/v1#note') do |index|
        index.as :displayable
      end

      # VRA
      property :culturalContext, :predicate => OregonDigital::Vocabularies::VRA.culturalContext do |index|
        index.as :displayable
      end
      property :idCurrentRepository, :predicate => OregonDigital::Vocabularies::VRA.idCurrentRepository do |index|
        index.as :searchable, :displayable
      end

      # EXIF
      property :imageWidth, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#width') do |index|
        index.as :displayable
      end
      property :imageHeight, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#height') do |index|
        index.as :displayable
      end
      property :imageResolution, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#resolution') do |index|
        index.as :displayable
      end
      property :imageOrientation, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#orientation') do |index|
        index.as :displayable
      end
      property :colorSpace, :predicate => RDF::URI('http://www.w3.org/2003/12/exif/ns#colorSpace') do |index|
        index.as :displayable
      end

      # RDA
      property :formOfWork, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/w/formOfWork.en') do |index|
        index.as :displayable
      end
      property :fileSize, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/fileSize.en') do |index|
        index.as :displayable
      end
      property :layout, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/layout.en') do |index|
        index.as :displayable
      end
      property :containedInManifestation, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/containedInManifestation.en') do |index|
        index.as :displayable
      end
      property :modeOfIssuance, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/modeOfIssuance.en') do |index|
        index.as :displayable
      end
      property :placeOfProduction, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/placeOfProduction.en') do |index|
        index.as :displayable
      end
      property :descriptionOfManifestation, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/m/descriptionOfManifestation.en') do |index|
        index.as :displayable
      end
      property :colourContent, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/e/colourContent.en') do |index|
        index.as :displayable
      end
      property :biographicalInformation, :predicate => RDF::URI('http://www.rdaregistry.info/Elements/a/biographicalInformation.en') do |index|
        index.as :displayable
      end

      # SWPO
      property :containedInJournal, :predicate => RDF::URI('http://sw-portal.deri.org/ontologies/swportal#containedInJournal') do |index|
        index.as :displayable
      end
      property :isVolume, :predicate => RDF::URI('http://sw-portal.deri.org/ontologies/swportal#isVolume') do |index|
        index.as :displayable
      end
      property :hasNumber, :predicate => RDF::URI('http://sw-portal.deri.org/ontologies/swportal#hasNumber') do |index|
        index.as :displayable
      end
    end
  end
end
