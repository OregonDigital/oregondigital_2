require 'rails_helper'

RSpec.describe OregonDigital::Fields::InputFactory do
  let(:field_factory) {described_class.create(object, property)}
  let(:object) {double("form object")}
  let(:object_class) {double("form object class")}
  let(:property) {:property}
  let(:multiple){}

  before do
    allow(object).to receive(:class).and_return(object_class)
    allow(object_class).to receive(:multiple?).with(property).and_return(multiple)
  end

  describe ".create" do
    context "When a multi input field is needed" do
      let(:multiple) {true}

      it "should return a multi input field" do
        expect(field_factory).to be_instance_of(OregonDigital::Fields::MultiInput)
      end
    end
    context "When a multi input field is not needed" do
      let(:multiple) {false}

      it "should return an input field" do
        expect(field_factory).to be_instance_of(OregonDigital::Fields::Input)
      end
    end
  end
end
