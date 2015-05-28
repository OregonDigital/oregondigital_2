require 'rails_helper'

RSpec.describe HasURIInputType do
  subject { described_class.new(base_input) }
  let(:base_input) { build_base_input }
  let(:options) { Hash.new }

  describe "#options" do
    it "should add input type" do
      expect(subject.options).to eq(options.merge(:input_html => {:type => "uri_enabled_string"}))
    end
  end

  def build_base_input
    i = instance_double(HydraEditor::Fields::Input)
    allow(i).to receive(:options).and_return(options)
    i
  end
end
