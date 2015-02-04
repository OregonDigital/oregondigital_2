require 'rails_helper'

RSpec.describe Document do
  verify_contract :document
  let(:resource_class) { Document }
  subject { resource_class.new }
  describe "contracts" do
    it "should be able to have an id" do
      expect(resource_class.new(:id => "1").id).to eq "1"
    end
  end

  describe "#pdf_pages" do
    let(:path) { Rails.root.join("tmp", "documents").to_s }
    it "should have derivative accessors for pdf_pages" do
      expect(subject).to have_derivative_accessors_for(:pdf_pages, [true, path])
    end
  end

end
