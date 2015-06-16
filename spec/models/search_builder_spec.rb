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

end
