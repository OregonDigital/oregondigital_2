class Document < GenericAsset
  has_derivatives :pdf_pages, :ocr, :thumbnail

  def to_solr
    return super if joined_words.empty?
    super.merge({ActiveFedora::SolrQueryBuilder.solr_name("full_text", "tsimv") => joined_words})
  end

  def ocr_reader
    OregonDigital::OCRReader::Reader.new(ocr_content.to_s)
  end

  def ocr_content
    File.read(ocr_path) unless ocr_path.nil?
  end

  def joined_words
    ocr_reader.stringified_words.join(" ") 
  end
  
end
