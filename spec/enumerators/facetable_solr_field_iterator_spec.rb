require 'rails_helper'

RSpec.describe FacetableSolrFieldIterator do
  subject { described_class.new(solr_field_summary) }
  let(:solr_field_summary) { SolrFieldSummary.new(field_summary) }
  let(:field_summary) do
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

  describe "#each" do
    it "should order by distinct" do
      expect(subject.to_a.map(&:first)).to eq [:workType, :alternative, :title]
    end
    it "should only have data model keys" do
      expect(subject.to_a.map(&:first)).not_to include :bad_key
    end
  end
end
