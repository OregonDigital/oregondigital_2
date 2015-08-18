require 'rails_helper'

RSpec.describe IpConverter do
  describe ".i_to_ip" do
    context "with a valid integer" do
      it "should return an IP address string" do
        expect(IpConverter.i_to_ip(1234567890)).to eq("73.150.2.210")
      end
    end

    context "with an invalid value" do
      it "should return nil" do
        expect(IpConverter.i_to_ip(-1)).to eq(nil)
        expect(IpConverter.i_to_ip("21")).to eq(nil)
      end
    end
  end

  describe ".ip_to_i" do
    context "with a valid IP address" do
      it "should return an IP address integer" do
        expect(IpConverter.ip_to_i("73.150.2.210")).to eq(1234567890)
      end
    end

    context "with an invalid value" do
      it "should return nil" do
        expect(IpConverter.ip_to_i("foo")).to eq(nil)
        expect(IpConverter.ip_to_i("127.0.0.256")).to eq(nil)
        expect(IpConverter.ip_to_i("127.0.0.*")).to eq(nil)
      end
    end
  end
end
