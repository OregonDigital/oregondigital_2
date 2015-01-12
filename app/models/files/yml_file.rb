module Files
  class YmlFile < ActiveFedora::File
    include Solrizer::Common

    def self.index_types
      [:searchable, :facetable, :displayable, :symbol]
    end

    def content
      serialize
    end

    def content=(content)
      super
      @inner_hash = deserialize(content)
    end

    def inner_hash
      @inner_hash ||= deserialize
    end

    def serialize
      serialization = inner_hash.to_h.stringify_keys if inner_hash.respond_to?(:to_h)
      serialization.blank? ? "".to_yaml : serialization.to_yaml
    end

    def deserialize(data=nil)
      data ||= local_or_remote_content(true)
      data = YAML.load(data.to_s) || {}
      data = {} if data.blank?
      data = RecursiveOpenStruct.new(data) if data.kind_of?(Hash)
      return data || RecursiveOpenStruct.new()
    end

    def serialize!
      @content = serialize
    end

    def prefix(name,pre=nil)
      name = name.to_s unless name.is_a? String
      pre ||= "#{dsid.underscore}" if dsid
      return "#{pre}__#{name}".gsub(/^__/,'').to_sym
    end

    # TODO: Refactor this into an indexing service.
    def to_solr(solr_doc = Hash.new,opts={})
      item ||= opts.fetch(:item, nil)
      term_prefix ||= opts.fetch(:term_prefix, nil)
      name ||= opts.fetch(:name, nil)
      name += "__" if name
      item ||= {} if inner_hash.kind_of?(String)
      item ||= inner_hash.to_h
      item.each do |key, value|
        term_key = (name.to_s + prefix(key,term_prefix).to_s).to_sym
        value = Array.wrap(value)
        value.each do |v|
          if v.kind_of?(Hash)
            solr_doc = self.to_solr(solr_doc, {:item => v, :term_prefix => term_key})
            next
          end
          v = v.to_s
          self.class.create_and_insert_terms(term_key, v, self.class.index_types, solr_doc)
        end
      end
      solr_doc
    end

    private

    # Delegate missing methods to the underlying hash.
    def method_missing(method, *args, &block)
      inner_hash.send(method, *args, &block)
    end

    def respond_to_missing?(method_name, include_private=false)
      true
    end

  end
end
