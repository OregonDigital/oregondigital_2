require 'rails_helper'

RSpec.describe IpBasedGroup, :type => :model do
  describe ".for_ip" do
    context "when the ip is nil" do
      it "should return an empty set" do
        expect(IpBasedGroup.for_ip(nil)).to eq([])
      end
    end

    context "when the ip is invalid" do
      it "should return an empty set" do
        expect(IpBasedGroup.for_ip("foo.bar.baz.quux")).to eq([])
      end
    end

    context "when the ip is valid" do
      before do
        create_group("local", "127.0.0.0/16")
        create_group("local0", "127.0.0.0/24")
        create_group("local1", "127.0.1.0/24")
        create_group("local2", "127.0.2.0/24")
      end

      it "should return all groups the ip is within" do
        expect(IpBasedGroup.for_ip("127.0.0.5")).to contain_exactly("local", "local0")
        expect(IpBasedGroup.for_ip("127.0.2.5")).to contain_exactly("local", "local2")
      end
    end
  end

  describe "#ip_start" do
    let(:group) { create_group("test", "127.0.0.1/24") }
    it "should return the stringified version of the first IP address" do
      expect(group.ip_start).to eq("127.0.0.0")
    end
  end

  describe "#ip_end" do
    let(:group) { create_group("test", "127.0.0.1/24") }
    it "should return the stringified version of the last IP address" do
      expect(group.ip_end).to eq("127.0.0.255")
    end
  end

  describe "#ip_start=" do
    let(:group) { FactoryGirl.build(:ip_based_group) }

    context "for a valid IP address" do
      it "should set ip_start_i to an integer" do
        group.ip_start = "127.0.0.0"
        expect(group.ip_start_i).to eq(2130706432)
      end
    end

    context "for an invalid IP address" do
      it "should set ip_start_i to nil" do
        group.ip_start = "127.0.0.-1"
        expect(group.ip_start_i).to eq(nil)
      end
    end

    it "should change #ip_start to return the value assigned" do
      group.ip_start = "foo"
      expect(group.ip_start).to eq("foo")
    end
  end

  describe "#ip_end=" do
    let(:group) { FactoryGirl.build(:ip_based_group) }

    context "for a valid IP address" do
      it "should set ip_end_i to an integer" do
        group.ip_end = "127.0.0.255"
        expect(group.ip_end_i).to eq(2130706687)
      end
    end

    context "for an invalid IP address" do
      it "should set ip_end_i to nil" do
        group.ip_end = "127.0.0.256"
        expect(group.ip_end_i).to eq(nil)
      end
    end

    it "should change #ip_end to return the value assigned" do
      group.ip_end = "foo"
      expect(group.ip_end).to eq("foo")
    end
  end

  describe "IP string validations" do
    let(:group) { FactoryGirl.build(:ip_based_group) }
    let(:ip_start) { "223.0.0.1" }
    let(:ip_end) { "223.0.0.255" }
    before do
      group.ip_start = ip_start
      group.ip_end = ip_end
    end

    context "when start and end IP are valid" do
      it "should be valid" do
        expect(group).to be_valid
      end
    end

    context "when start IP is invalid" do
      let(:ip_start) { "foo" }
      it "should be invalid" do
        expect(group).not_to be_valid
      end

      it "should add an error on ip_start" do
        group.valid?
        expect(group.errors[:ip_start]).not_to be_blank
      end
    end

    context "when end IP is invalid" do
      let(:ip_end) { "foo" }
      it "should be invalid" do
        expect(group).not_to be_valid
      end

      it "should add an error on ip_end" do
        group.valid?
        expect(group.errors[:ip_end]).not_to be_blank
      end
    end
  end

  def create_group(name, range)
    cidr = NetAddr::CIDR.create(range)
    group = FactoryGirl.build(:ip_based_group, :role_name => name)
    group.ip_start_i = cidr.first(:Objectify => true).to_i
    group.ip_end_i = cidr.last(:Objectify => true).to_i
    group.save!
    group
  end
end
