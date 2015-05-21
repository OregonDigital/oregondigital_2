require 'rails_helper'

RSpec.describe ClassConfiguration do
  subject { described_class.new(property, class_name_map) }
  let(:property) { Property.new(:name => "order", :class_name => "wrong") }
  let(:class_name_map) { {:order => class_name}}
  let(:class_name) { double("class_name") }

  describe "#to_h" do
    it "should return the configured class name" do
      expect(subject.to_h).to include({:class_name => class_name})
    end
  end

  describe "#class_name" do
    it "should return the configured class name" do
      expect(subject.class_name).to eq class_name
    end
  end
end
