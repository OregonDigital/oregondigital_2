require 'rails_helper'

RSpec.describe StreamableContent do
  verify_contract :streamable_content
  describe "#path" do
    context "when it has a mime_type of image/jpeg" do
      it "should be test_item.jpg" do
        content = StreamableContent.new("bla", "image/jpeg")

        expect(content.path).to eq "test_item.jpg"
      end
    end
  end
end
