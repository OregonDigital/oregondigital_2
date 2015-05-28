require 'rails_helper'

RSpec.describe AttributeURIConverter do
  describe "#convert_attributes" do
    it "converts all URI-like values in a hash to RDF" do
      attrs = {
        # Simplest case
        :d => "scheme://host",

        # Broken "URI"
        :e => "http:example.com",

        # String
        :f => "definitely not a uri",

        # Array with a URI and a non-URI
        :g => ["http://example.org", "also not a uri"]
      }
      converted = AttributeURIConverter.new(attrs).convert_attributes
      expect(converted).to eq({
        :d => RDF::URI("scheme://host"),
        :e => "http:example.com",
        :f => "definitely not a uri",
        :g => [RDF::URI("http://example.org"), "also not a uri"]
      })
    end
  end
end
