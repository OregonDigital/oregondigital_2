module OregonDigital::Derivatives
  class DelayedRunner
    pattr_initialize :runner, :job_factory
    delegate :to_a, :to => :runner

    def run(asset)
      # Have to marshal the runner because ActiveJob doesn't, and there's no
      # unique ID for them.
      job_factory.perform_later(asset.id, Marshal.dump(runner))
    end

    class Factory
      pattr_initialize :base_runner_factory, :job_factory

      def new(*args)
        DelayedRunner.new(base_runner_factory.new(*args), job_factory)
      end
    end
  end
end
