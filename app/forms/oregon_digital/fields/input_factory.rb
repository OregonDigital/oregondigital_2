module OregonDigital
  module Fields
    class InputFactory
      class << self
        def create(object, property)
          decorate do
            base_factory.create(object, property)
          end
        end

        private

        def decorate
          decorator.new(yield)
        end

        def decorator
          HasHintOption
        end

        def base_factory
          HydraEditor::Fields::Factory
        end
      end
    end
  end
end
