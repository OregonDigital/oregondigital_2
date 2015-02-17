module OregonDigital::Derivatives::Runners
  class ImageRunners
    attr_accessor :runner_builder, :asset

    def initialize(runner_builder)
      @runner_builder = runner_builder
    end

    def run(asset)
      @asset = asset
      runner_list.run(asset)
    end

    private

    def list
      [
        runner_builder.pyramidal_runner(asset.id),
        runner_builder.thumbnail_runner(asset.id),
        runner_builder.medium_runner(asset.id)
      ]
    end

    def runner_list
      runner_builder.runner_list.new(list)
    end
  end
end
