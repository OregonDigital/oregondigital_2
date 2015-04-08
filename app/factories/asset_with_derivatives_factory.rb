class AssetWithDerivativesFactory
  class << self
    delegate :runner_finder_factory, :lazy_runner_factory, :to => :derivative_service_locator

    def new(asset)
      AssetWithDerivatives.new(asset, lazy_runner)
    end

    private

    def derivative_service_locator
      OregonDigital.derivative_injector
    end

    def runner_finder
      runner_finder_factory.new(derivative_service_locator)
    end

    def lazy_runner
      lazy_runner_factory.new(runner_finder)
    end
  end
end
