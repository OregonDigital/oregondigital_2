class CreateDerivativesJob < ActiveJob::Base
  queue_as :low

  def perform(id, runner)
    asset = GenericAsset.find(id)
    runner.run(asset)
  end
end
