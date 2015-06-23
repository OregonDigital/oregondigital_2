module OregonDigital::Derivatives
  class DerivativeCallback
    attr_accessor :asset

    def initialize(asset)
      @asset = asset
    end

    def success(type, path)
      asset.__send__(:"has_#{type}=", true)
      asset.__send__(:"#{type}_path=", CapistranoAwarePath.new(path).to_s)
    end

  end
end
