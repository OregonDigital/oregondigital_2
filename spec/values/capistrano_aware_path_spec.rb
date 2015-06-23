require 'rails_helper'

RSpec.describe CapistranoAwarePath do
  subject { described_class.new(path) }

  context "when given a capistrano release path" do
    let(:path) { "/data0/www/od2/releases/123123/media/1.jpg" }
    it "should point to the shared media path" do
      expect(subject.to_s).to eq "/data0/www/od2/shared/media/1.jpg"
    end
  end
  context "when given the capistrano release root" do
    let(:path) { "/data0/www/od2/releases/123123" }
    it "should point to the shared media path" do
      expect(subject.to_s).to eq "/data0/www/od2/shared"
    end
  end
end
