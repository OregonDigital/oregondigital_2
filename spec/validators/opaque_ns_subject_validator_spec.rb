require 'rails_helper'

RSpec.describe OpaqueNsSubjectValidator do
  subject { described_class.new }
  describe "#valid?" do
    let(:base_uri) { "http://opaquenamespace.org/ns/subject" }
    let(:validator) { instance_double(BaseUriValidator) }
    let(:value) { ["#{base_uri}/1"] }
    it "should ask BaseUriValidator" do
      allow(BaseUriValidator).to receive(:new).with(base_uri).and_return(validator)
      validation_result = double("Result")
      allow(validator).to receive(:valid_value?).and_return(validation_result)

      result = subject.valid_value?(value)

      expect(validator).to have_received(:valid_value?).with(value)
      expect(result).to eq validation_result
    end
  end

  describe "#message" do
    it "should be right" do
      expect(subject.message).to eq "contains a non opaque namespace term"
    end
  end
end
