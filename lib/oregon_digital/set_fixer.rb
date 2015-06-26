module OregonDigital
  class SetFixer

    attr_reader :solr_service, :repository

    def initialize(solr_service, repository)
      @solr_service = solr_service
      @repository = repository
    end

    def fix_set
      change_set_ids
    end

    private

    def change_set_ids
      bad_ids.each do |id|
        asset = repository.find(id)
        asset.set = asset.set_ids.map{|set_id| uri_conversion(set_id)}
        asset.save
      end
    end

    def uri_conversion(set_id)
      RDF::URI(repository.id_to_uri(repository.uri_to_id(set_id.to_s).split(":").last)) 
    end

    def bad_ids
      solr_service.query(query_string, :fl => :id, :rows => 10000).map{|x| x["id"]}
    end

    def query_string
      "set_ssim:#{RSolr.solr_escape(resource_url)}*" 
    end

    def resource_url
      "http://oregondigital.org/resource"
    end
  end
end
