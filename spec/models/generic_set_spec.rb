require 'rails_helper'

RSpec.describe GenericSet do
  let(:resource_class) { GenericSet }
  subject { resource_class.new }

  describe '#resource' do
    before do
      subject.title << "test"
    end
    it "should be able to be saved" do
      expect{subject.save}.not_to raise_error
    end
    it "should have an institution attribute" do
      expect(subject).to respond_to :institution
    end
  end
end
