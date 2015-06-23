require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::DerivativeCallback do
  subject { OregonDigital::Derivatives::DerivativeCallback.new(asset) }
  let(:asset) { object_double(Image.new).as_null_object }
  image_paths = {
    :thumbnail => Rails.root.join("tmp", "1.jpg"),
    :medium => Rails.root.join("tmp", "1.jpg"),
    :pyramidal => Rails.root.join("tmp", "1.tiff")
  }
  document_paths = {
    :pdf_pages => Rails.root.join("tmp", "documents"),
    :ocr => Rails.root.join("tmp", "ocr.html")
  }

  describe "#success" do
    context "for an image" do
      context "when given a capistrano path" do
        before do
          subject.success(:thumbnail, Pathname.new("/data0/www/od2/releases/12312123/media/thumbnails/1/2/2.jpg"))
        end
        it "should set path to the cap symlink" do
          expect(asset).to have_received(:thumbnail_path=).with("/data0/www/od2/shared/media/thumbnails/1/2/2.jpg")
        end
      end
      image_paths.each do |type, path|
        before do
          subject.success(type, path.to_s)
        end
        it "should set has_#{type}" do
          expect(asset).to have_received(:"has_#{type}=").with(true)
        end
        it "should set #{type}_path" do
          expect(asset).to have_received(:"#{type}_path=").with(path.to_s)
        end
      end
    end
    context "for a document" do
      let(:asset) { object_double(Document.new).as_null_object }
      document_paths.each do |type, path|
        before do
          subject.success(type, path.to_s)
        end
        it "should set has_#{type}" do
          expect(asset).to have_received(:"has_#{type}=").with(true)
        end
        it "should set #{type}_path" do
          expect(asset).to have_received(:"#{type}_path=").with(path.to_s)
        end
      end
    end
  end
end
