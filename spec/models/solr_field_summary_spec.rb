require 'rails_helper'

RSpec.describe SolrFieldSummary do
  describe ".where" do
    context "when given a field" do
      subject { described_class.where(:field => "*") }
      it "should return a field summary" do
        GenericAsset.create do |c|
          c.title = ["Test"]
        end

        expect(subject).to be_kind_of SolrFieldSummary
        expect(subject["title"].distinct).to eq 1
      end
    end
  end

  describe "[]" do
    subject { described_class.new(field_document) }
    let(:field_document) do
      {
        "title_preferred_label_ssim" => 
        {
          "docs" => 36,
          "distinct" => 36,
          "topTerms" => [
            "Label",
            "Other Label"
          ]
        },
        "title_ssim" =>
        {
          "docs" => 10,
          "distinct" => 6,
          "topTerms" => [
            "Test",
            "Test2"
          ]
        }
      }
    end
    it "should access by the base property name" do
      expect(subject["title"]).to be_kind_of SolrFieldSummary::Field
    end
    it "should work with symbols as a key" do
      expect(subject[:title]).to be_kind_of SolrFieldSummary::Field
    end
    it "should not work for non-existent properties" do
      expect(subject[:banana]).to eq nil
    end
    it "should add derivative keys" do
      expect(subject[:title].derivative_properties[:preferred_label].distinct).to eq 36
    end
    it "should not give derivative keys its own property" do
      expect(subject.keys).to eq [:title]
    end
  end
end

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
