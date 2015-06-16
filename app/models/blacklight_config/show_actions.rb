class BlacklightConfig
  class ShowActions
    pattr_initialize :configuration

    def run
      add_edit_button
      remove_defaults
    end

    private

    def add_edit_button
      configuration.show.document_actions[:edit_record] = Blacklight::Configuration::ToolConfig.new(:partial => "edit_action")
    end

    def remove_defaults
      default_actions.each do |action|
        configuration.show.document_actions.delete(action)
      end
    end

    def default_actions
      [:refworks, :endnote, :email, :sms, :citation, :librarian_view]
    end
  end
end
