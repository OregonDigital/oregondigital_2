require 'rails_helper'

RSpec.describe ApplyProperties do
  subject { described_class.new(properties) }
  let(:properties) do
    {
      :title => config_double
    }
  end
  let(:config_double) do
    d = double("config_double")
    allow(d).to receive(:predicate).and_return(RDF::DC.title)
    allow(d).to receive(:class_name).and_return(class_name)
  end
  let(:class_name) { double("class_name") }
  describe "#apply!" do
    let(:asset) { object_double(GenericAsset) }
    it "should call #property for each defined property" do
      allow(asset).to receive(:property)

      subject.apply!(asset)

      expect(asset).to have_received(:property).with(:title, {:predicate => RDF::DC.title, :class_name => class_name})
    end
  end
end
