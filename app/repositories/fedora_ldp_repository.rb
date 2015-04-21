class FedoraLDPRepository
  attr_reader :subject
  def initialize(subject)
    @subject = RDF::URI(subject)
  end

  def <<(stuff)
    temp_graph = subject_changer.call(stuff, self.subject, absolute_path)
    resource.graph << temp_graph
    resource.save
  end

  def query(query_params)
    subject_changer.call(resource.graph,
                        connection.http.url_prefix.to_s,
                        self.subject)
  end

  def delete(query_to_delete)
    true
  end

  private

  def subject_changer
    OregonDigital::GraphMutators::SubjectChanger
  end

  def relative_path
    "."+ActiveFedora.fedora.base_path+"/"+subject.host+subject.path
  end

  def absolute_path
    RDF::URI(connection.http.url_prefix.to_s+"/"+relative_path)
  end


  def resource
    @resource ||= Ldp::Resource::RdfSource.new(connection, relative_path, nil, ActiveFedora.fedora.base_path)
  end

  def connection
    @connection ||= ActiveFedora.fedora.connection
  end
end
