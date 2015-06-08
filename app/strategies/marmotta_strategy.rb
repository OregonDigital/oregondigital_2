class MarmottaStrategy
  include ActiveTriples::PersistenceStrategy
  attr_reader :obj, :connection
  attr_accessor :parent
  def initialize(obj, connection)
    @obj = obj
    @connection = connection
  end

  def destroy
    erase_old_resource
    @destroyed = true
  end

  def persist!
    erase_old_resource
    resource.post(obj)
    @persisted = true
  end

  def erase_old_resource
    resource.delete
  end

  def reload
    obj << resource.get
    @persisted = true unless obj.empty?
    true
  end

  class Factory
    pattr_initialize :connection

    def new(obj)
      MarmottaStrategy.new(obj, connection)
    end
  end

  private

  def resource
    @resource ||= Marmotta::Resource.new(obj.rdf_subject.to_s, connection: connection)
  end

end
