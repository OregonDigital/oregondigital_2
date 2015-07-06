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
          ],
          "dynamicBase" => "*_ssim"
        },
        "title_tesim" => 
        {
          "docs" => 10,
          "distinct" => 6,
          "dynamicBase" => "*_tesim"
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
      expect(subject[:title_preferred_label].distinct).to eq 36
    end
    it "should only do ssim keys" do
      expect(subject[:title].dynamicBase).to eq "*_ssim"
    end
  end
end
