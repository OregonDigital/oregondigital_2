require 'rails_helper'

RSpec.describe CleanRepository do
  subject { described_class.new(ActiveFedora.fedora.connection, ActiveFedora::Base) }
  describe "#find" do
    let(:asset) do
      g = GenericAsset.new
      g.title = ["Test"]
      g
    end
    context "when given an existing asset" do
      it "should return its graph un-modified" do
        asset.save
        result_graph = subject.find(asset.id)

        expect(result_graph.statements.to_a.length).to eq 1
        expect(result_graph.statements.to_a.first).to eq [asset.rdf_subject, RDF::DC.title, "Test"]
      end
    end
  end
end
