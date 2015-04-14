require 'rails_helper'

RSpec.describe ODDataModel do
  subject { described_class.new }
  describe "#simple_properties" do
    it "should return a hash of properties" do
      expect(subject.simple_properties).to include ({:title => RDF::DC.title})
    end
  end
end
