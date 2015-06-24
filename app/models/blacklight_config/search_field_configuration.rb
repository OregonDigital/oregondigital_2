class BlacklightConfig
  class SearchFieldConfiguration
    pattr_initialize :configuration

    def run
      fields.each do |f|
        add_field(f)
      end
    end

    private

    def fields
      [all_field] | normal_fields
    end

    def normal_fields
      %w{title description creator lcsubject date institution}.map do |field|
        SearchField.new(field, :qf => Solrizer.solr_name(field, :stored_searchable))
      end
    end

    def add_field(field)
      configuration.add_search_field field.key, :label => field.label do |f|
        f.solr_parameters = field.solr_parameters
      end
    end

    def all_field
      SearchField.new("all_fields", :qf => "all_text_timv")
    end
  end
end
