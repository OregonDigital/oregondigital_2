require 'rails_helper'

RSpec.describe OregonDigital::Fields::InputFactory do
  describe "#create" do
    it "should return an input that can have a hint" do
      object = GenericAsset.new
      result = described_class.create(object, :lcsubject)
      expect(result.property).to eq :lcsubject
      expect(result.options).to include ({:hint => nil})
    end
  end
end
