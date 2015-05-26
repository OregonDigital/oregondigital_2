module OregonDigital
  # Simple hackery to make a field that has a URI auto-switch to read-only
  # while still being able to be removed.  Called from a simpleform input to
  # generate HTML for the view.
  class URIEnabledStringField
    def initialize(builder, attribute_name, options)
      @builder = builder
      @attribute_name = attribute_name
      @options = options
    end

    def field
      if @options[:value].respond_to?(:rdf_label)
        rdf_field
      else
        @builder.text_field(@attribute_name, @options)
      end
    end

    private

    def rdf_field
      rdf_text_field + rdf_uri_field
    end

    # Returns effectively a dummy field just for displaying a friendly label
    def rdf_text_field
      @builder.text_field(@attribute_name, @options.merge(
        :id => nil,
        :name => nil,
        :value => label,
        :readonly => true,
      ))
    end

    # Returns the actual important RDF data: the URI
    def rdf_uri_field
      @builder.hidden_field(@attribute_name, @options.merge(:value => subject))
    end

    def label
      @options[:value].rdf_label.first.to_s
    end

    def subject
      @options[:value].rdf_subject.to_s
    end
  end
end
