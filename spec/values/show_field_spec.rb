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
    it "should be humanized" do
      expect(subject.label).to eq "Title"
    end
  end
end
