require 'rails_helper'

RSpec.describe OregonDigital::Fields::InputFactory do
  subject { described_class.new(base_factory, decorator) }
  let(:base_factory) { build_input_factory }
  let(:decorator) { build_decorator }
  let(:decorated_input) { double("decorated input") }
  let(:input) { double("input") }

  describe "#create" do
    it "decorate the input" do
      object = build_object

      result = subject.create(object, :lcsubject)

      expect(result).to eq decorated_input
      expect(decorator).to have_received(:new).with(input)
      expect(base_factory).to have_received(:create).with(object, :lcsubject)
    end

    def build_object
      instance_double(GenericAssetForm)
    end
  end

  def build_input_factory
    f = object_double(HydraEditor::Fields::Factory)
    allow(f).to receive(:create).and_return(input)
    f
  end
  def build_decorator
    f = object_double(HasHintOption)
    allow(f).to receive(:new).and_return(decorated_input)
    f
  end
end
