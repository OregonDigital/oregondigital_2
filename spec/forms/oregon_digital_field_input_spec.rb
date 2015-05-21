require 'rails_helper'

RSpec.describe OregonDigital::Fields::Input do
  let(:input) {described_class.new(object, property)}
  let(:property) {:property}
  let(:object) {double("form object")}
  
  describe "#options" do
    let(:field_input_options) {input.options}
    let(:required) {double("required")}

    before do
      allow(object).to receive(:required?).with(property).and_return(required)
    end

    context "when fields are left as their default values" do
      it "should match the default values" do
        expect(field_input_options).to match(:required => required)
      end
    end

    context "When field_type is defined" do
      before do
        input.field_type = :blah
      end
      it "should set the field_type" do
        expect(input.field_type).to eq :blah
      end
    end

    context "When input_html_options is defined" do
      before do
        input.input_html_options = :thing
      end
      it "should set the field_type" do
        expect(input.input_html_options).to eq :thing 
      end
    end

    context "When wrapper_html_options is defined" do
      before do
        input.wrapper_html_options = :other_thing
      end
      it "should set the field_type" do
        expect(input.wrapper_html_options).to eq :other_thing
      end
    end
  end
end
