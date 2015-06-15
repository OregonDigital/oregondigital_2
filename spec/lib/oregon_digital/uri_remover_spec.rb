require 'rails_helper'

RSpec.describe OregonDigital::URIRemover do
  let(:uri_remover) {described_class.new(value)}
  let(:value) {"Blah$http://www.blah.com"}

  describe "#to_s" do
    it "should remove a uri in a field value" do
      expect(uri_remover.to_s).to eq "Blah"
    end
    context "when using a value without a uri in it" do
      let(:value) {"Blah"}
      it "should return that value" do
        expect(uri_remover.to_s).to eq "Blah"
      end
    end
  end
end
