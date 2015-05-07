require 'rails_helper'

RSpec.describe ApplyProperties do
  subject { described_class.new(properties, SolrApplicationStrategy.new) }
  let(:properties) do
    [config_double]
  end
  let(:config_double) do
    d = double("config_double")
    allow(d).to receive(:name).and_return(:title)
    allow(d).to receive(:to_h).and_return(:predicate => RDF::DC.title, :class_name => class_name)
    d
  end
  let(:class_name) { double("class_name") }
  describe "#apply!" do
    let(:asset) { object_double(GenericAsset) }
    it "should call #property for each defined property" do
      solr_configuration = double("solr_configuration")
      allow(asset).to receive(:property).and_yield(solr_configuration)
      allow(solr_configuration).to receive(:as)

      subject.apply!(asset)

      expect(asset).to have_received(:property).with(:title, {:predicate => RDF::DC.title, :class_name => class_name})
      expect(solr_configuration).to have_received(:as).with(:searchable, :displayable, :facetable)
    end
  end
end
