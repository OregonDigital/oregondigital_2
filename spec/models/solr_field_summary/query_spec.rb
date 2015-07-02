require 'rails_helper'

RSpec.describe SolrFieldSummary::Query do
  subject { described_class.new(field: "*") }
  describe "#result" do
    it "should return the solr result" do
      GenericAsset.create do |c|
        c.title = ["Test"]
      end

      expect(subject.result.keys).to include "title_ssim"
    end
  end
end
