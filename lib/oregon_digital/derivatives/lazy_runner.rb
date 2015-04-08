##
# This class finds runners for a given asset, but ONLY when you try to use it as
# a runner. This is required because assets don't have an ID until
# post-persistence, and AssetWithDerivatives needs runners at instantiation.
module OregonDigital::Derivatives
  class LazyRunner
    attr_reader :asset, :runner_finder
    def initialize(runner_finder)
      @runner_finder = runner_finder
    end

    def run(asset)
      runners(asset).run(asset)
    end

    private

    def runners(asset)
      runner_finder.find(asset)
    end
  end
end
