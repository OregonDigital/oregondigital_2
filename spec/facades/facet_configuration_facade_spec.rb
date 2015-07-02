require 'rails_helper'

RSpec.describe FacetConfigurationFacade do
  subject { described_class.new }
  before do
    allow(SolrFieldSummary).to receive(:where).and_return(solr_summary)
  end

  let(:solr_summary) { SolrFieldSummary.new(document) }
  let(:document) do
    {
      "workType_ssim" => 
      {
        "distinct" => 36
      },
      "title_ssim" =>
      {
        "distinct" => 5
      },
      "alternative_ssim" =>
      {
        "distinct" => 10
      },
      "bad_key_ssim" =>
      {
        "distinct" => 3
      }
    }
  end

  describe "#active" do
    context "when there are no active facets" do
      it "should be an empty hash" do
        expect(subject.active).to be_blank
      end
    end
    context "when there are active facets" do
      it "should contain settings for them" do
        facet = FacetField.create(:key => "title")

        expect(subject.active.to_h.keys.first).to eq :title
        expect(subject.active.to_h.values.first.distinct).to eq 5
        expect(subject.active.to_h.values.first.facet).to eq facet
      end
    end
  end

  describe "#inactive" do
    context "when there are no active facets" do
      it "should have all the fields" do
        expect(subject.inactive.to_h.keys).to eq [:workType, :alternative, :title]
        expect(subject.inactive.to_h[:workType].facet).not_to be_persisted
      end
    end
    context "when there are active facets" do
      it "should have only the non-active fields" do
        FacetField.create(:key => "title")
        
        expect(subject.inactive.to_h.keys).to eq [:workType, :alternative]
      end
    end
  end
end
