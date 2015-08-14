require 'spec_helper'

RSpec.describe RecordID do
  subject { described_class.new(id) }
  describe "#old?" do
    context "with an old id" do
      let(:id) { "oregondigital:5" }
      it { should be_old }
    end
    context "with a new id" do
      let(:id) { "id" }
      it { should_not be_old }
    end
  end

  describe "#value" do
    context "with an old id" do
      let(:id) { "oregondigital:5" }
      it "should be just the last part" do
        expect(subject.value).to eq "5"
      end
    end
    context "with a new id" do
      let(:id) { "5" }
      it "should return it" do
        expect(subject.value).to eq "5"
      end
    end
  end
end
