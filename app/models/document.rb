class Document < GenericAsset
  has_derivatives :pdf_pages, :ocr
end
