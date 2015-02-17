module OregonDigital::Derivatives::Runners
  class DocumentRunners
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
        runner_builder.pdf_runner(asset.id)
      ]
    end

    def runner_list
      runner_builder.runner_list.new(list)
    end
  end
end
