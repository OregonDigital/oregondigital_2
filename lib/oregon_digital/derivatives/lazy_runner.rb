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
