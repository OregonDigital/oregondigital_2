require_relative 'null_runner'
module OregonDigital::Derivatives::Runners
  class RunnerFinder
    delegate :runner_list, :thumbnail_runner, :medium_runner, :pyramidal_runner, :pdf_runner, :to => :injector
    delegate :id, :to => :asset
    def self.find(asset)
      new(asset).runners
    end

    attr_accessor :asset
    def initialize(asset)
      @asset = asset
    end

    def runners
      runner_list.new(Array.wrap(found_runners))
    end

    private

    # Refactor this.
    def found_runners
      return image_runners if asset.kind_of? ::Image
      return document_runners if asset.kind_of? ::Document
      ::OregonDigital::Derivatives::Runners::NullRunner.new
    end

    def image_runners
      [
        thumbnail_runner(id),
        medium_runner(id),
        pyramidal_runner(id)
      ]
    end

    def document_runners
      [
        pdf_runner(id)
      ]
    end

    def injector
      OregonDigital.derivative_injector
    end
  end
end
