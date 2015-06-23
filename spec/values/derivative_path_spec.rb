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
    context "given a path from the server" do
      let(:path) { Pathname.new("/data0/od2.library.oregonstate.edu/releases/20150623202821/media/thumbnails/j/s/d08f659sj.jpg") }
      it "should return correctly" do
        allow(subject).to receive(:injector).and_return(injector)
        allow(injector).to receive(:derivative_base).and_return(Pathname.new("/data0/od2.library.oregonstate.edu/releases/20150623221531/media"))
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
end
