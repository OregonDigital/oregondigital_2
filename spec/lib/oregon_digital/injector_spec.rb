require 'rails_helper'

RSpec.describe OregonDigital::Injector do
  verify_contract :injector
  let(:resource) { OregonDigital::Injector.new }

  describe "#thumbnail_path" do
    context "when given an id" do
      let(:id) { "1" }
      let(:result) { resource.thumbnail_path(id) }
      it "should return a good path" do
        expect(result).to eq Rails.root.join("media", "1", "0", "1.jpg").to_s
      end
    end
  end
end
