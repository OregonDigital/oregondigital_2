require 'rails_helper' 

RSpec.describe GenericAssetForm do
  let(:generic_form){ instance_double(described_class) }
  let(:property) { :lcsubject }
  let(:message) { "This is my message" }

  context "#property_hint" do
    before do
      allow(generic_form).to receive(:property_hint).with(property).and_return(message)
    end

    it "should return a string hint composed of validation messages" do
      expect(generic_form.property_hint(property)).to eq "This is my message"
    end
  end
end
