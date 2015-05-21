module OregonDigital
  module Fields
    class InputFactory
      def self.create(object, property)
        if object.class.multiple?(property)
          MultiInput.new(object, property)
        else
          Input.new(object, property)
        end
      end
    end
  end
end
