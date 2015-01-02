require 'linkeddata'
require 'rdf/cli/vocab-loader'
module OregonDigital
  module RDF
    ##
    # Overrides some ruby-rdf specific stuff in RDF::VocabularyLoader.
    # One day it might also do some better/custom nvocab parsing.
    class VocabularyLoader < ::RDF::VocabularyLoader
      attr_accessor :fetch
      def initialize(*args)
        super
        @module_name = "OregonDigital::Vocabularies"
      end

      # Actually executes the load-and-emit process - useful when using this
      # class outside of a command line - instantiate, set attributes manually,
      # then call #run
      def run
        @output.print %(# -*- encoding: utf-8 -*-
        # This file generated automatically using vocab-fetch from #{source}
        require 'rdf'
        module #{module_name}
          class #{class_name} < RDF::#{"Strict" if @strict}Vocabulary("#{uri}")
        ).gsub(/^        /, '') if @output_class_file

        if fetch

          # Extract statements with subjects that have the vocabulary prefix and organize into a hash of properties and values
          vocab = ::RDF::Vocabulary.load(uri, location: source, extra: @extra)

          # Split nodes into Class/Property/Datatype/Other
          term_nodes = {
            class: {},
            property: {},
            datatype: {},
            other: {}
          }

          # FIXME: This can try to resolve referenced terms against the previous version of this vocabulary, which may be strict, and fail if the referenced term hasn't been created yet.
          vocab.each.to_a.sort.each do |term|
            name = term.to_s[uri.length..-1].to_sym
            kind = case term.type.to_s
                   when /Class/    then :class
                   when /Property/ then :property
                   when /Datatype/ then :datatype
                   else                 :other
                   end
            term_nodes[kind][name] = term.attributes
          end

          {
            class: "Class definitions",
            property: "Property definitions",
            datatype: "Datatype definitions",
            other: "Extra definitions"
          }.each do |tt, comment|
            next if term_nodes[tt].empty?
            @output.puts "\n    # #{comment}"
            term_nodes[tt].each {|name, attributes| from_node name, attributes, tt}
          end
        end

        # Query the vocabulary to extract property and class definitions
        @output.puts "  end\nend" if @output_class_file
      end
    end
  end
end
