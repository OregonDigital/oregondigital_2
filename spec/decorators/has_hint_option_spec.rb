require 'rails_helper'

RSpec.describe HasHintOption do
  subject { described_class.new(base_input) }
  let(:object) { instance_double(GenericAssetForm) }
  let(:base_input) { instance_double(HydraEditor::Fields::Input) }
  let(:validators) { {} }
  let(:property) { :lcsubject }
  let(:nil_message) {[nil].compact}
  let(:validator_message) {["Here is a message"]}
  let(:validator_messages) {["Here is a message", "another"]}
 

  describe "#hint" do
    before do
      allow(base_input).to receive(:object).and_return(object)
      allow(base_input).to receive(:property).and_return(property) 
      allow(object).to receive(:property_hint).and_return(nil_message)
    end

    context "when there are no messages to return" do
      it "should return nil" do
        expect(subject.hint).to eq nil
      end
    end
    context "when there is a validator" do
      before do
        allow(object).to receive(:property_hint).and_return(validator_message.to_sentence) 
      end
      
      it "should return that validator's message" do
        expect(subject.hint).to eq "Must fulfill: Here is a message"
      end
      context "With multiple validator messages" do
        before do
          allow(object).to receive(:property_hint).and_return(validator_messages.to_sentence) 
        end

        it "should return those messages comma delimited" do
          expect(subject.hint).to eq"Must fulfill: Here is a message and another"
        end
      end
    end
  end
end
