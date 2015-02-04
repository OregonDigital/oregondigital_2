require 'rails_helper'

RSpec.describe Image do
  verify_contract :image
  subject { Image.new }

  describe "contracts" do
    it "should be able to have an id" do
      expect(Image.new(:id => "1").id).to eq "1"
    end
  end


  [:thumbnail, :medium, :pyramidal].each do |derivative|
    it "should have derivative accessors for #{derivative}" do
      extension = derivative == :pyramidal ? "tiff" : "jpg" 
      path = Rails.root.join("tmp", "1.#{extension}").to_s 
      expect(subject).to have_derivative_accessors_for derivative, [true, path]
    end
  end

end
