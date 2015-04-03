class CleanRepository
  attr_reader :connection, :id_converter
  def initialize(connection, id_converter)
    @connection = connection
    @id_converter = id_converter
  end

  def find(id)
    ConvertedSubject.new(id, connection.get(uri(id))).graph
  end

  private

  def uri(id)
    id_converter.id_to_uri(id)
  end

  class ConvertedSubject < SimpleDelegator
    attr_reader :id
    def initialize(id, result)
      @id = id
      super(result)
    end

    def graph
      @graph ||= OregonDigital::GraphMutators::SubjectChanger.call(__getobj__.graph, GenericAsset.id_to_uri(id), RDF::URI("http://oregondigital.org/resource/#{id}"))
    end
  end
end
