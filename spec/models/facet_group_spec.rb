require 'rails_helper'

RSpec.describe FacetGroup do
  subject { described_class.new }
  describe "pref_label" do
    it "should return the label string" do
      expect(subject.pref_label(subject.properties.first.uberfield)).to eq subject.properties.first.uberfield.to_s + "_preferred_label_ssim"
    end
  end
  describe "ssim" do
    it "should return the ssim string" do
      expect(subject.ssim(subject.properties.first.uberfield)).to eq subject.properties.first.uberfield.to_s + "_ssim"
    end
  end
end
