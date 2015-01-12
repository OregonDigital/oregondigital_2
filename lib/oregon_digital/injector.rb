module OregonDigital
  class Injector
    def thumbnail_path(id)
      distributor = OregonDigital::FileDistributor.new(id)
      distributor.extension = '.jpg'
      distributor.path
    end
  end
end
