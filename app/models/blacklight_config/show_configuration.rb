class BlacklightConfig
  class ShowConfiguration
    pattr_initialize :configuration, :metadata_class

    def run
      apply_show_fields
      apply_edit_config
    end

    private

    def apply_show_fields
      show_fields.each do |field|
        configuration.add_show_field field.key, :label => field.label
      end
    end

    def apply_edit_config
      configuration.show.document_actions[:edit_record] = Blacklight::Configuration::ToolConfig.new(:partial => "edit_action")
    end

    def show_fields
      metadata_class.properties.keys.map{|x| ShowField.new(x) }
    end
  end
end
