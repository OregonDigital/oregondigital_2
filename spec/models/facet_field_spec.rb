require 'rails_helper'

RSpec.describe FacetField, type: :model do
  describe "validations" do
    it { should validate_presence_of :key }
  end

  describe "#view_label" do
    subject { described_class.new(:key => "awesome_title", :label => label) }
    context "when there's no label" do
      let(:label) {}
      it "should be a titleized key" do
        expect(subject.view_label).to eq "Awesome Title"
      end
    end
    context "when there's a label" do
      let(:label) { "Testing" }
      it "it should be the label" do
        expect(subject.view_label).to eq "Testing"
      end
    end
  end
end
