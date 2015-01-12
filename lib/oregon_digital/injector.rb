module OregonDigital
  class Injector
    def thumbnail_path(id)
      distributor = OregonDigital::FileDistributor.new(id)
      distributor.extension = '.jpg'
      distributor.base_path = Rails.root.join("media", "thumbnails")
      distributor.path
    end

    def medium_path(id)
      distributor = OregonDigital::FileDistributor.new(id)
      distributor.extension = '.jpg'
      distributor.base_path = Rails.root.join("media", "medium-images")
      distributor.path
    end
  end
end
