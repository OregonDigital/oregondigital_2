module OregonDigital
  module Fields
    class Input
      attr_accessor :object, :property, :field_type, :input_html_options, :wrapper_html_options

      def initialize(object, property)
        @object = object
        @property = property
      end

      def required?
        return object.required?(property)
      end

      def hint?
        nil
      end

      def all_options
        {
          required: required?,
          as: field_type,
          input_html: input_html_options,
          wrapper_html: wrapper_html_options,
          hint: hint?,
        }
      end

      def options
        all_options.select {|option, method| method != nil }
      end
    end
  end
end
