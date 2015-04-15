require 'rails_helper'

RSpec.describe WithValidatedProperty do
  subject { WithValidatedProperty.new(asset, property, validator) }
  let(:asset) { object_double(GenericAsset.new) }
  let(:property) { :title }
  let(:validator) { double("Validator") }
  let(:result) { double("result") }
  let(:errors) { ActiveModel::Errors.new(result) }
  before do
    allow(asset).to receive(:title).and_return(result)
    #allow(asset).to receive(:get_values).with(property, :cast => false).and_return(result)
    allow(asset).to receive(:errors).and_return(errors)
    allow(asset).to receive(:valid?).and_return(true)
    allow(errors).to receive(:add).and_call_original
    allow(validator).to receive(:message).and_return("is so awful")
  end

  describe "#valid?" do
    let(:valid) { true }
    before do
      allow(validator).to receive(:valid?).with(result).and_return(valid)
      subject.valid?
    end
    it "should call asset.valid?" do
      expect(asset).to have_received(:valid?)
    end
    context "when validator returns true" do
      it "should not add any errors" do
        expect(errors).not_to have_received(:add)
      end
      it "should return true" do
        expect(subject.valid?).to eq true
      end
    end
    context "when validator returns false" do
      let(:valid) { false }
      it "should add an error" do
        expect(errors).to have_received(:add).with(property, "is so awful")
      end
      it "should return false" do
        expect(subject.valid?).to eq false
      end
    end
  end
end
