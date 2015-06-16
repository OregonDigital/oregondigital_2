class BlacklightConfig
  class ShowConfiguration
    pattr_initialize :configuration, :metadata_class

    def run
      apply_show_fields
    end

    private

    def apply_show_fields
      show_fields.each do |field|
        configuration.add_show_field field.key, :label => field.label
      end
    end

    def show_fields
      metadata_class.properties.keys.map{|x| ShowField.new(x) }
    end
  end
end
