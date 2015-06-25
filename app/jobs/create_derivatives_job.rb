class CreateDerivativesJob < ActiveJob::Base
  queue_as :low

  def perform(id, runner_marshalled)
    asset = GenericAsset.find(id)
    runner = Marshal.load(runner_marshalled)
    runner.run(asset)
  end
end
