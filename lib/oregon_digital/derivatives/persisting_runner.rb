module OregonDigital::Derivatives
  class PersistingRunner < SimpleDelegator
    def run(asset)
      super
      asset.save
    end
    class Factory
      pattr_initialize :base_factory

      def new(*args)
        PersistingRunner.new(base_factory.new(*args))
      end
    end
  end
end
