class IndexingService < ActiveFedora::IndexingService
  # Override rdf_service to allow indexing AF::Base objects.
  def rdf_service
    IdentifiableIndexing
  end

  def generate_solr_document
    super.tap do |solr_doc|
      solr_doc.merge!('public_bsi' => decorated_object.public?)
      solr_doc.merge!('reviewed_bsi' => decorated_object.reviewed?)
      solr_doc.merge!("full_text_tsimv" => joined_words) unless joined_words.empty? 
    end
  end

  private

  def ocr_reader
    OregonDigital::OCRReader::Reader.new(ocr_content.to_s)
  end

  def ocr_content
    File.read(object.ocr_path) if object.respond_to?(:ocr_path) && !object.ocr_path.nil?
  end

  def joined_words
    ocr_reader.stringified_words.join(" ") 
  end

  def decorated_object
    @decorated_object ||= Reviewable.new(object)
  end
end
