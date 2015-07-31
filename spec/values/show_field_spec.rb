require 'rails_helper'

RSpec.describe ShowField do
  subject { described_class.new(property) }
  let(:property) { :title }
  describe "#key" do
    it "should be right" do
      expect(subject.key).to eq ActiveFedora::SolrQueryBuilder.solr_name(property, :symbol)
    end
  end

  describe "#label" do
    it "should be contain the predicate it represents" do
      expect(subject.label).to eq "<span data-predicate=\"http://purl.org/dc/terms/title\">Title</span>"
    end
  end
end
