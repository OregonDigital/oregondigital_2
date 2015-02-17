module OregonDigital::Derivatives
  class DerivativeCallback
    attr_accessor :asset

    def initialize(asset)
      @asset = asset
    end

    def thumbnail_success(path)
      asset.has_thumbnail = true
      asset.thumbnail_path = path
    end

    def medium_success(path)
      asset.has_medium = true
      asset.medium_path = path
    end

    def pyramidal_success(path)
      asset.has_pyramidal = true
      asset.pyramidal_path = path
    end

    def pdf_success(path)
      asset.has_pdf_pages = true
      asset.pdf_pages_path = path
    end
    
    def ocr_success(path)
      asset.has_ocr = true
      asset.ocr_path = path
    end
  end
end
