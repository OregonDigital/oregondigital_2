require 'rails_helper'

RSpec.describe Image do
  verify_contract :image
  subject { Image.new }

  describe "contracts" do
    it "should be able to have an id" do
      expect(Image.new(:id => "1").id).to eq "1"
    end

    describe "#content_content_changed" do
      context "when content changes" do
        it "should be true" do
          image = Image.new
          image.content.content = "bla"

          expect(image.content_content_changed?).to eq true
        end
      end
      context "when content doesn't change" do
        it "should be false" do
          image = Image.new

          expect(image.content_content_changed?).to eq false
        end
      end
      context "when content is blank" do
        it "should be false" do
          image = Image.new
          image.content.content = ""
          
          expect(image.content_content_changed?).to eq false
        end
      end
    end

    describe "#injector" do
      fake(:injector)
      before do
        make_equal_to_fakes(subject.injector)
      end
      it "should use OregonDigital's injector" do
        expect(subject.injector).to eq OregonDigital.inject
      end
    end

    describe "#content" do
      before do
        make_equal_to_fakes(subject.content)
      end
      it "should be a FileContent" do
        expect(subject.content).to be_kind_of FileContent
      end
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
