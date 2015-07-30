require 'rails_helper'

RSpec.describe ExternalAssetForm do
  describe ".terms" do
    it "should include oembed" do
      expect(described_class.terms).to include :oembed
    end
  end
end
