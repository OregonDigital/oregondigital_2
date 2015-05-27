require 'rails_helper'

RSpec.describe HasHintOption do
  subject { described_class.new(base_input) }
  let(:object) { instance_double(GenericAssetForm) }
  let(:base_input) { instance_double(HydraEditor::Fields::Input) }
  let(:validators) { {} }
  let(:property) { :lcsubject }

  describe "#hint" do
    before do
        allow(base_input).to receive(:object).and_return(object)
        allow(base_input).to receive(:property).and_return(property)
        allow(object).to receive(:validators).and_return(validators)
    end
    context "when there is no validator" do
      it "should return nil" do
        expect(subject.hint).to eq nil
      end
    end
    context "when there is a validator" do
      let(:validator) { instance_double(SubjectCvValidator) }
      let(:validators) do
        {
          property => [validator]
        }
      end
      it "should return that validator's message" do
        allow(validator).to receive(:message).and_return("be awesome")

        expect(subject.hint).to eq "Must fulfill: be awesome"
      end
    end
  end
end
