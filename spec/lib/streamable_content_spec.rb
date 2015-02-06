require 'rails_helper'

RSpec.describe StreamableContent do
  verify_contract :streamable_content
  subject { StreamableContent.new(string, mime_type) }
  let(:string) { "bla" }
  let(:mime_type) { "image/jpeg" }
  describe "#path" do
    let(:result) { subject.path }
    context "when given something with a mime_type of 'image/jpeg'" do
      it "should be test_item.jpg" do
        expect(result).to eq "test_item.jpg"
      end
    end
  end
end
