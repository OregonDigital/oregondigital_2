module OregonDigital::Derivatives
  class RunnerFinder
    delegate :runner_list, :to => :runner_builder
    attr_reader :asset, :runner_builder
    def initialize(runner_builder)
      @runner_builder = runner_builder
    end

    def find(asset)
      @asset = asset
      runner_list.new(mapped_runners)
    end

    private

    def mapped_runners
      asset.derivatives.map do |derivative|
        runner_builder.__send__(runner_builder_method(derivative), asset.id)
      end
    end

    def runner_builder_method(derivative)
      "#{derivative}_runner"
    end
  end

end
