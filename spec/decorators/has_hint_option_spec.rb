require 'rails_helper'

RSpec.describe HasHintOption do
  subject { described_class.new(base_input) }
  let(:object) { build_object }
  let(:base_input) { build_base_input }
  let(:validators) { {} }
  let(:property) { :lcsubject }

  describe "#hint" do
    context "when there is no validator" do
      it "should return nil" do
        expect(subject.hint).to eq nil
      end
    end
    context "when there is a validator" do
      let(:validators) do
        {
          property => [validator]
        }
      end
      let(:validator) { build_validator }

      it "should return that validator's message" do
        expect(subject.hint).to eq "Must fulfill: be awesome"
      end
    end
  end

  def build_validator
    instance_double(SubjectCvValidator).tap do |f|
      allow(f).to receive(:message).and_return("be awesome")
    end
  end

  def build_base_input
    instance_double(HydraEditor::Fields::Input).tap do |f|
      allow(f).to receive(:object).and_return(object)
      allow(f).to receive(:property).and_return(property)
    end
  end

  def build_object
    instance_double(GenericAssetForm).tap do |f|
      allow(f).to receive(:validators).and_return(validators)
    end
  end
end
