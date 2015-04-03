require 'rails_helper'

RSpec.describe CleanRepository do

end

RSpec.describe PreferHeaders do
  let(:header_string) { "return=representation; omit=\"http://1.1.1 http://2.3/b\"; prefer=\"http://2.2.2\"" }
  subject { PreferHeaders.new(header_string) }

  describe "#return" do
    it "should return what's being returned" do
      expect(subject.return).to eq "representation"
    end
  end

  describe "#omit" do
    it "should return omit array" do
      expect(subject.omit).to eq ["http://1.1.1", "http://2.3/b"]
    end
  end

  describe "#prefer" do
    it "should return prefer array" do
      expect(subject.prefer).to eq ["http://2.2.2"]
    end
  end

  describe "#prefer=" do
    it "should set prefer" do
      subject.prefer = ["http://3.3.3", "http://1.1.1"]
      
      expect(subject.prefer).to eq ["http://3.3.3", "http://1.1.1"]
      expect(subject.to_s).to eq "return=representation; omit=\"http://1.1.1 http://2.3/b\"; prefer=\"http://3.3.3 http://1.1.1\""
    end
    it "should be able to set a single value" do
      subject.prefer = "http://3.3.3"
      expect(subject.to_s).to eq "return=representation; omit=\"http://1.1.1 http://2.3/b\"; prefer=\"http://3.3.3\""
    end
    context "when set to nothing" do
      it "should not serialize that value" do
        subject.prefer = []
        expect(subject.to_s).to eq "return=representation; omit=\"http://1.1.1 http://2.3/b\""
      end
    end
  end

  describe "#omit=" do
    it "should set omit" do
      subject.omit = ["http://3.3.3", "http://1.1.1"]

      expect(subject.omit).to eq ["http://3.3.3", "http://1.1.1"]
      expect(subject.to_s).to eq "return=representation; omit=\"http://3.3.3 http://1.1.1\"; prefer=\"http://2.2.2\""
    end
    context "when set to nothing" do
      it "should not serialize that value" do
        subject.omit = []
        expect(subject.to_s).to eq "return=representation; prefer=\"http://2.2.2\""
      end
    end
  end
end
