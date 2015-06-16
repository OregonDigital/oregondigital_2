class BlacklightConfig
  class ApplySet
    pattr_initialize :configuration, :set

    def run
      update_show_route
    end

    private

    def update_show_route
      configuration.show.route = {:controller => "sets", :set_id => set.id.to_s}
    end
  end
end
