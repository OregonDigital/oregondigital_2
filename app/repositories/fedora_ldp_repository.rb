class FedoraLDPRepository
  attr_reader :subject
  def initialize(subject)
    @subject = RDF::URI(subject)
  end

  def <<(stuff)
    temp_graph = SubjectMutater.new(stuff, self.subject, absolute_path).graph
    resource.graph << temp_graph
    resource.save
  end

  def relative_path
    "."+ActiveFedora.fedora.base_path+"/"+subject.host+subject.path
  end

  def absolute_path
    RDF::URI(connection.http.url_prefix.to_s+"/"+relative_path)
  end

  def query(query_params)
    SubjectMutater.new(resource.graph,
                       connection.http.url_prefix.to_s,
                       self.subject).graph
  end

  def resource
    @resource ||= Ldp::Resource::RdfSource.new(connection, relative_path, nil, ActiveFedora.fedora.base_path)
  end

  def delete(query_to_delete)
    true
  end

  def connection
    @connection ||= ActiveFedora.fedora.connection
  end
end

class SubjectMutater
  pattr_initialize :source_graph, :find, :replace
  def graph
    temp_graph = RDF::Graph.new
    source_graph.statements.to_a.each do |statement|
      s = statement.subject
      if s.start_with?(find.to_s)
        s = replace
      end
      temp_graph << [s, statement.predicate, statement.object]
    end
    temp_graph
  end
end
