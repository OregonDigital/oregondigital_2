require 'rails_helper'

RSpec.describe DecorateProperties do
  subject { DecorateProperties.new(resource, property_mapper) }
  let(:resource) { object_double(GenericAsset.new) }
  let(:property_mapper) do
    {
      :title => [
        validator,
        validator2
      ]
    }
  end
  let(:validator) { fake_validator(true) }
  let(:validator2) { fake_validator(true) }

  describe "#run" do
    before do
      allow(WithValidatedProperty).to receive(:new).and_call_original
    end
    it "should decorate the given properties" do
      result = subject.run

      expect(WithValidatedProperty).to have_received(:new).with(resource, :title, validator)
      expect(WithValidatedProperty).to have_received(:new).with(result.__getobj__, :title, validator2)
    end
  end

  def fake_validator(result=true)
    v = double("Validator")
    allow(v).to receive(:valid?).with(resource).and_return(result)
    allow(v).to receive(:message).and_return("has a bad validation")
    v
  end
end
