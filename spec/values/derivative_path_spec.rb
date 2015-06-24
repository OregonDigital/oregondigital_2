require 'rails_helper'

RSpec.describe DerivativePath do
  subject { described_class.new(path) }
  let(:injector) { OregonDigital.derivative_injector }
  let(:path) { injector.thumbnail_path("test") }

  describe "#to_s" do
    it "should return the path's to_s" do
      expect(subject.to_s).to eq path.to_s
    end
  end

  describe "#relative_path" do
    it "should return a relative path" do
      expect(subject.relative_path).to eq Pathname.new("/media/thumbnails/t/s/test.jpg")
    end
    context "when instantiated with a string path" do
      let(:path) { injector.thumbnail_path("test").to_s }
      it "should work" do
        expect(subject.relative_path).to eq Pathname.new("/media/thumbnails/t/s/test.jpg")
      end
    end
  end

  describe "#derivative_type" do
    let(:result) { subject.derivative_type }
    context "given a thumbnail" do
      it "should return :thumbnail" do
        expect(result).to eq :thumbnail
      end
    end
    context "given a pyramidal" do
      let(:path) { injector.pyramidal_path("test") }
      it "should return a pyramidal" do
        expect(result).to eq :pyramidal
      end
    end
    context "given a medium image" do
      let(:path) { injector.medium_path("test") }
      it "should return medium_image" do
        expect(result).to eq :medium_image
      end
    end
  end

  describe "#to_iiif" do
    let(:path) { injector.pyramidal_path("test") }
    let(:result) { subject.to_iiif }

    it "should produce a link to the IIIF server's info.json" do
      expect(result.to_s).to eq "http://localhost/path/to/iiif/media%2Fpyramidal%2Ft%2Fs%2Ftest.tiff/info.json"
    end
  end
end
