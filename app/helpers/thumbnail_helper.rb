module ThumbnailHelper
  include Blacklight::CatalogHelper
  # Had to override the thumbnail URL because the document doesn't directly have
  # the relative URL, just the raw location of the thumbnail on disk.
  def thumbnail_url document
    document.derivative_paths[:thumbnail].relative_path.to_s
  end
end
