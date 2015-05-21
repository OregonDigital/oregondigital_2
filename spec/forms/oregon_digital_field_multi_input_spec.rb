require 'rails_helper'

RSpec.describe OregonDigital::Fields::MultiInput do
  let(:input) { described_class.new(object, property) }
  let(:object) { double("form object") }
  let(:property) { :property }

  describe "#options" do
    let(:field_input_options) { input.options }
    let(:required) { double("required") }

    before do
      allow(object).to receive(:required?).with(:property).and_return(required)
    end

    it "should return all the input options" do
      expect(field_input_options).to match(:required => required, 
                                           :as => :multi_value,
                                           :input_html => { class: "form-control" },
                                           :wrapper_html => { class: "repeating-field" })
    end
  end
end
