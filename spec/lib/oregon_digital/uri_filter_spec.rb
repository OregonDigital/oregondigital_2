require 'rails_helper'

RSpec.describe OregonDigital::URIFilter do
  let(:filter) {described_class.new(value, uri_detector)}
  let(:value) {"Here is my value"}
  let(:uri_detector) {MaybeURI}
  describe "#filter" do
    context "when passed a value that is not a uri" do
      it "should return the value" do
        expect(filter.filter).to eq value
      end
    end
    context "when passed a value that is a uri" do
      let(:value) {"http://www.blah.com"}
      it "should return nil" do
        expect(filter.filter).to eq nil
      end
    end
  end
end
