require 'rails_helper'

RSpec.describe CleanRepository do
  subject { described_class.new(ActiveFedora.fedora.clean_connection, ActiveFedora::Base) }
  describe "#find" do
    let(:asset) do
      g = GenericAsset.new("1")
      g.title = ["Test"]
      g
    end
    context "when given an existing asset" do
      it "should return its graph with a clean subject" do
        asset.save
        result_graph = subject.find(asset.id)

        expect(result_graph.statements.to_a.length).to eq 1
        expect(result_graph.statements.to_a.first).to eq [RDF::URI("http://oregondigital.org/resource/1"), RDF::DC.title, "Test"]
      end
    end
  end
end
