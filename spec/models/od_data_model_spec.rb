require 'rails_helper'

RSpec.describe ODDataModel do
  subject { described_class.new }
  describe "#simple_properties" do
    it "should return a hash of properties" do
      expect(subject.simple_properties).to include ({:title => RDF::DC.title})
    end
  end

  describe "#properties" do
    it "should not not cast oembed" do
      expect(subject.properties.find{|x| x.name == :oembed}.cast).to eq false
    end
  end
end
