class GenericSet < GenericAsset
  def self.from_uri(uri, *args)
    begin
      self.find(uri_to_id(uri))
    rescue
      ActiveTriples::Resource.new(uri)
    end
  end
end
