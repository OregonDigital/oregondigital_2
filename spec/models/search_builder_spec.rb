require 'rails_helper'

RSpec.describe SearchBuilder do
  let(:scope) { nil }
  let(:processor_chain) { [] }
  subject { described_class.new(processor_chain, scope) }

  describe "#restrict_to_set" do
    let(:processor_chain) { [:restrict_to_set] }
    context "when there is no set" do
      it "should not do anything" do
        expect(subject.processed_parameters[:fq]).to eq []
      end
    end
    context "when there is a non-uri set" do
      it "should not do anything" do
        subject.set = "Banana"
        expect(subject.processed_parameters[:fq]).to eq []
      end
    end
    context "when there is a set" do
      it "should restrict to it" do
        subject.set = double("Set", :uri => "http://imauri.com")

        expect(subject.processed_parameters[:fq]).to eq ["set_ssim:http\\:\\/\\/imauri.com"]
      end
    end
  end

  describe "#filter_set_admin" do
    let(:processor_chain) { [:filter_set_admin] }
    let(:add_visible_item) { create :facet_item, :value => "banana", :visible => true }
    let(:remove_first_item) { create :facet_item, :value => "hello", :visible => false }
    let(:remove_second_item) { create :facet_item, :value => "world", :visible => false }

    context "when there is no set" do
      it "should not do anything" do
        expect(subject.processed_parameters[:fq]).to eq []
      end
    end

    context "when there is a set with multiple items" do
      it "should display visible items" do
        add_visible_item
        expect(subject.processed_parameters[:fq].first).not_to match(/banana/)
      end
      it "should filter out removed items" do
        add_visible_item
        remove_first_item
        remove_second_item
        expect(subject.processed_parameters[:fq]).to eq ["set_ssim:(-\"hello\"-\"world\")"]
        expect(subject.processed_parameters[:fq].first).not_to match(/banana/)
      end
    end
  end
end
